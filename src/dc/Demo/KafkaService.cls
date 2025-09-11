Class dc.Demo.KafkaService Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.Kafka.InboundAdapter";

Property Adapter As EnsLib.Kafka.InboundAdapter;

Method OnProcessInput(pInput As %Net.Remote.Object, Output pOutput As %RegisteredObject) As %Status
{
    Set sc = $$$OK

    Try {
		Set tMsg = ##class(EnsLib.Kafka.Message).%New()
		
        Do tMsg.FromRemoteObject(pInput)

        Set req = ##class(Ens.StringRequest).%New()
        
        Set req.StringValue = tMsg.value
        
        Set sc = ..SendRequestSync("SendToKafkaTopic", req, .tResponse)
        
        If $$$ISERR(sc) Return sc
        
        Set pOutput = tResponse
        
	}
	Catch (ex) {
		Set sc = ex.AsStatus()
	}
    
    Return sc
}

}
