#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/mobility-module.h"
#include "ns3/gsm-module.h"
#include "ns3/config-store-module.h"

using namespace ns3;

int main (int argc, char *argv[])
{
  // Create the nodes
  NodeContainer nodes;
  nodes.Create (2);

  // Install the GSM stack on the nodes
  GsmHelper gsm;
  NetDeviceContainer devices = gsm.Install (nodes);

  // Set the positions of the nodes
  MobilityHelper mobility;
  Ptr<ListPositionAllocator> positionAlloc = CreateObject<ListPositionAllocator> ();
  positionAlloc->Add (Vector (0.0, 0.0, 0.0));
  positionAlloc->Add (Vector (5.0, 0.0, 0.0));
  mobility.SetPositionAllocator (positionAlloc);
  mobility.Install (nodes);

  // Create the channels
  GsmChannelHelper channel;
  channel.AddPropagationLoss ("ns3::FriisPropagationLossModel");
  channel.AddPropagationDelay ("ns3::ConstantSpeedPropagationDelayModel");
  channel.SetPropagationDelay ("ns3::ConstantSpeedPropagationDelayModel",
                               "Delay", TimeValue (MilliSeconds (2)));
  channel.SetPropagationLoss ("ns3::FriisPropagationLossModel",
                              "Frequency", DoubleValue (900000000.0));
  channel.SetPropagationLoss ("ns3::FriisPropagationLossModel",
                              "SystemLoss", DoubleValue (1));
  channel.SetPropagationLoss ("ns3::FriisPropagationLossModel",
                              "Distance", DoubleValue (5));

  // Create the physical layer
  GsmPhyHelper phy = GsmPhyHelper ();
  phy.SetChannel (channel.Create ());
  phy.SetDevice (devices);
  phy.SetMobility (nodes);

  // Create the MAC layer
  GsmMacHelper mac = GsmMacHelper ();
  mac.SetPhy (phy);
  mac.SetDevice (devices);
  mac.SetMobility (nodes);

  mac.Install ();

  AsciiTraceHelper ascii;
  p2ph.EnableAsciiAll(ascii.CreateFileStream("cdma.tr"));
  Simulator::Run ();
  Simulator::Destroy ();

  return 0;
}
