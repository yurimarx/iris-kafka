Class dc.Demo.Setup
{

ClassMethod StartProduction()
{
    set prodClass = "dc.Demo.Production"
    do ##class(%EnsembleMgr).SetAutoStart($namespace, prodClass)
    job ##class(Ens.Director).StartProduction(prodClass)
}

}
