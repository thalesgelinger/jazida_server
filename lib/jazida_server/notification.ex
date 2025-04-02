defmodule JazidaServer.Notification do
  alias JazidaServer.Loads.Load
  @push_api_url "https://api.onesignal.com/notifications?c=push"

  def push(%Load{} = load) do
    message = build_message(load)

    image_path = JazidaServerWeb.Endpoint.url() <> "/api" <> load.signature_path

    body =
      Jason.encode!(%{
        app_id: System.get_env("ONESIGNAL_APP_ID"),
        headings: %{en: "Nova Carga 🚛"},
        contents: %{en: message},
        included_segments: ["Active Subscriptions"],
        target_channel: "push",
        ios_attachments: %{
          id: image_path
        },
        big_picture: image_path,
        data: %{
          id: load.id,
          quantity: load.quantity,
          material: load.material.name,
          client: load.client.name,
          plate: load.plate.name,
          payment: load.payment_method
        }
      })

    rest_token = System.get_env("ONESIGNAL_REST_API_KEY")

    headers = [
      {"Content-Type", "application/json"},
      {"accept", "application/json"},
      {"Authorization", "Key " <> rest_token}
    ]

    request = Finch.build(:post, @push_api_url, headers, body)
    require Logger

    case Finch.request(request, JazidaServer.Finch) do
      {:ok, %Finch.Response{status: status, body: response_body}} ->
        Logger.info("📢 OneSignal Notification Sent! ✅ Status: #{status}")
        Logger.debug("📩 Response Body: #{response_body}")

        {:ok, Jason.decode!(response_body)}

      {:error, reason} ->
        Logger.error("❌ OneSignal Notification Failed! Reason: #{inspect(reason)}")

        {:error, reason}
    end
  end

  def build_message(%Load{} = load) do
    payment_method =
      case load.payment_method do
        :installment -> "a prazo"
        :cash -> "a prazo"
      end

    "Cliente: #{load.client.name}, #{load.quantity}m de #{load.material.name}. 🚚 Placa: #{load.plate.name}. Pagamento: #{payment_method}."
  end
end
