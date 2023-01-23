#include <iostream> #include"ns3/core-module.h"
#include "ns3/network-module.h" #include "ns3/csma-module.h" #include "ns3/applications-module.h" #include"ns3/internet-apps-module.h" #include"ns3/internet-module.h"

using namespace ns3; NS_LOG_COMPONENT_DEFINE("Lab-Program-2");
static void PingRtt (std::string context, Time rtt)
{
std::cout<< context <<""<<rtt<< std::endl;
}

int main (int argc, char *argv[])
{
CommandLinecmd; cmd.Parse (argc, argv);

// Here, we will explicitly create six nodes.
NS_LOG_INFO ("Createnodes."); NodeContainerc;
c.Create (6);

// connect all our nodes to a shared channel.
NS_LOG_INFO ("BuildTopology."); CsmaHelpercsma;
csma.SetChannelAttribute("DataRate",DataRateValue(DataRate(10000))); csma.SetChannelAttribute ("Delay", TimeValue (MilliSeconds (0.2))); NetDeviceContainerdevs= csma.Install(c);

// add an ip stack to allnodes. NS_LOG_INFO ("Add ip stack."); InternetStackHelperipStack; ipStack.Install (c);

// assign ip addresses

NS_LOG_INFO ("Assign ipaddresses."); Ipv4AddressHelper ip;
ip.SetBase ("10.1.1.0", "255.255.255.0");
Ipv4InterfaceContainer addresses = ip.Assign (devs); NS_LOG_INFO ("Create Sink.");
//CreateanOnOffapplicationtosendUDPdatagramsfromnodezerotonode1. NS_LOG_INFO ("CreateApplications.");
uint16_t port=9;    // Discard port (RFC863)

OnOffHelperonoff("ns3::UdpSocketFactory",
Address (InetSocketAddress (addresses.GetAddress (2), port)));
onoff.SetConstantRate (DataRate ("500Mb/s"));

ApplicationContainerapp = onoff.Install (c.Get (0));
// Start the application
app.Start (Seconds(6.0));
app.Stop (Seconds(10.0));

// Create an optional packet sink to receive these packets
PacketSinkHelpersink ("ns3::UdpSocketFactory",
Address (InetSocketAddress (Ipv4Address::GetAny (), port)));
app = sink.Install (c.Get (2));
app.Start (Seconds (0.0));

NS_LOG_INFO ("Create pinger");
V4PingHelperping=V4PingHelper(addresses.GetAddress(2)); NodeContainerpingers;
pingers.Add (c.Get(0));
pingers.Add (c.Get(1));

ApplicationContainerapps; apps = ping.Install(pingers); apps.Start (Seconds (1.0));
apps.Stop (Seconds (5.0));

// finally, print the ping rtts.
Config::Connect ("/NodeList/*/ApplicationList/*/$ns3::V4Ping/Rtt", MakeCallback (&PingRtt));
NS_LOG_INFO ("RunSimulation."); AsciiTraceHelperascii;
csma.EnableAsciiAll (ascii.CreateFileStream ("ping1.tr"));

Simulator::Run (); Simulator::Destroy (); NS_LOG_INFO ("Done.");
}


// ./waf - - run scratch/Program2 - -vis