#include "ns3/core-module.h" #include "ns3/network-module.h" #include "ns3/internet-module.h" #include"ns3/applications-module.h" #include <iostream>
#include "ns3/csma-module.h"
#include "ns3/network-application-helper.h" using namespacens3;
NS_LOG_COMPONENT_DEFINE ("3rd LabProgram"); using namespacens3;
NS_LOG_COMPONENT_DEFINE ("3rd Lab Program");

int
main (int argc, char *argv[])
{
CommandLinecmd; cmd.Parse (argc,argv);

NS_LOG_INFO ("Createnodes."); NodeContainernodes;
nodes.Create (4); //4 csma nodes are created

CsmaHelpercsma;
csma.SetChannelAttribute ("DataRate", StringValue ("5Mbps")); csma.SetChannelAttribute("Delay",TimeValue(MilliSeconds(0.0001)));

NetDeviceContainer devices; devices = csma.Install(nodes);

//RateErrorModel allows us to introduce errors into a Channel at a given rate.

Ptr<RateErrorModel>em = CreateObject<RateErrorModel> ();


em->SetAttribute ("ErrorRate", DoubleValue (0.00001));
devices.Get (1)->SetAttribute ("ReceiveErrorModel", PointerValue (em));

InternetStackHelperstack; stack.Install (nodes);

Ipv4AddressHelper address;
address.SetBase ("10.1.1.0", "255.255.255.0");
Ipv4InterfaceContainerinterfaces=address.Assign(devices); uint16_t sinkPort =8080;
AddresssinkAddress(InetSocketAddress(interfaces.GetAddress(1), sinkPort));

//PacketSink Application is used on the destination node to receiveTCP
//connections and data. Creates objects in an abstract way and associates
//type-id along with the object.

PacketSinkHelperpacketSinkHelper("ns3::TcpSocketFactory", InetSocketAddress (Ipv4Address::GetAny (), sinkPort));

//Install sinkapp on node 1

ApplicationContainersinkApps=packetSinkHelper.Install(nodes.Get(1)); sinkApps.Start (Seconds(0.));
sinkApps.Stop (Seconds(20.));

//next two lines of code will create the socket and connect the trace source.

Ptr<Socket>ns3TcpSocket=Socket::CreateSocket(nodes.Get(0), TcpSocketFactory::GetTypeId());
ns3TcpSocket->TraceConnectWithoutContext("CongestionWindow",MakeCallback (&CwndChange));

//creates an Object of type NetworkApplication (Class present innetwork-
//application-helper.h)

Ptr<NetworkApplication> app = CreateObject<NetworkApplication> ();

//Next statement tells the Application what Socket to use, what address to
//connect to, how much data to send at each send event, how many send events
//to generate and the rate at which to produce data from thoseevents.

app->Setup(ns3TcpSocket,sinkAddress,1040,1000,DataRate("50Mbps")); nodes.Get (0)->AddApplication(app);
app->SetStartTime (Seconds(1.));
app->SetStopTime (Seconds(20.));

//Displays packet drop msg

devices.Get (1)->TraceConnectWithoutContext("PhyRxDrop", MakeCallback (&RxDrop));

AsciiTraceHelperascii;
csma.EnableAsciiAll(ascii.CreateFileStream("3lan.tr")); csma.EnablePcapAll (std::string ("3lan"), true);



Simulator::Stop (Seconds(20)); Simulator::Run (); Simulator::Destroy ();

return 0;
}

// ./waf - - run scratch/Program3 - -vis Output
// Redirect the output to a file called cwnd.dat
// ./waf --run scratch/Program3 > cwnd.dat 2>&1 Now run gnuplot
// gnuplot> set terminal png size 640,480 gnuplot> set output "cwnd.png"
// gnuplot> plot "cwnd.dat" using 1:2 title 'Congestion Window' with linespointsgnuplot> exit
