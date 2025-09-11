Class dc.Demo.KafkaClient Extends %RegisteredObject
{

/// Description
ClassMethod Send() As %Status
{
    Set sc = $$$OK
    
    Set settings = ##class(%External.Messaging.KafkaSettings).%New()
    Set settings.servers = "kafka:9092"
    Set settings.clientId = "BazcoApp"
    // If Consumer, specify a consumer group
    Set settings.groupId = "G1"
    Set settings.securityprotocol="SASL_PLAINTEXT"
    Set settings.saslmechanism="PLAIN"

    Set client = ##class(%External.Messaging.Client).CreateClient(settings, .sc)

    Set producerSettings = "{""key.serializer"":""org.apache.kafka.common.serialization.StringSerializer""}"
    Set sc = client.UpdateProducerConfig(producerSettings)

    Set topic = "sample"
    Set value = "MyMessage", key = "OptionalTag"

    Set msg = ##class(%External.Messaging.KafkaMessage).%New()
    Set msg.topic = topic
    Set msg.value = value
    Set msg.key = key

    Set sc = client.SendMessage(msg)

    
    Return sc
}

/// Description
ClassMethod MethodName() As %Status
{
    Set tSC = $$$OK

    Try {
        
        set javaGate = $system.external.getJavaGateway()  
        do javaGate.addToPath("/tmp/kafka.jar")
        set kafka = javaGate.new("kafka.Test") 
        
        do kafka.send()
        
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }

    return tSC
}

}
