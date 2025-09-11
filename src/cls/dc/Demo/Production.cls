Class dc.Demo.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="dc.Demo.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description>This is a sample kafka production</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="SendToKafkaTopic" Category="" ClassName="dc.Demo.KafkaOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Servers">kafka:9092</Setting>
  </Item>
  <Item Name="ReceiveFromKafkaTopic" Category="" ClassName="dc.Demo.KafkaService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Servers">kafka:9092</Setting>
    <Setting Target="Adapter" Name="Topic">InTopic</Setting>
    <Setting Target="Adapter" Name="GroupID">kafka</Setting>
  </Item>
</Production>
}

}
