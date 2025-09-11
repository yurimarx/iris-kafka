Class dc.Demo.KafkaOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.Kafka.OutboundAdapter";

Property Adapter As EnsLib.Kafka.OutboundAdapter;

Property Topic As %String [ InitialExpression = "sample" ];

Parameter SETTINGS = "Topic:Basic";

/// Método que recebe uma mensagem do tipo MyProduction.Messages.KafkaEvent e envia para o Kafka.
/// Aqui, o tipo da mensagem recebida é 'Ens.StringRequest'.
/// Vamos usar uma mensagem de teste simples para o exemplo.
Method SendKafkaMessage(pRequest As Ens.StringRequest, Output pResponse As Ens.StringResponse) As %Status
{
    Set sc = $$$OK

    Set msg = ##class(%External.Messaging.KafkaMessage).%New()
    Set msg.topic = ..Topic
    Set msg.value = pRequest.StringValue
    Set msg.key = ..Adapter.ClientID
    Set sc = ..Adapter.SendMessage(msg)

    If $$$ISERR(sc) {
        $$$LOGERROR("Erro ao enviar mensagem para o Kafka: " _ $SYSTEM.Status.DisplayError(sc))
    }

    Set pResponse = ##class(Ens.StringResponse).%New()
    Set pResponse.StringValue = "Mensagem enviada com sucesso para o Kafka."

    Quit sc
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="Ens.StringRequest"> 
        <Method>SendKafkaMessage</Method>
    </MapItem>
</MapItems>
}

}
