import PacketScheduler.PacketScheduler;
public class Main
{
public static void main(String[] args)
{
/*
* Create a new packet scheduler.
 * Scheduler listens on UDP port 4444 for incoming *packets
 * and sends outgoing packets to localhost:4445.
 * Transmission rate of scheduler is 2Mbps. The scheduler
 * has 2 queues, and accepts packets of maximum size 1024
 * bytes.
* Capacity of first queue is 100*1024 bytes and capacity
 * if second queue is 200*1024 bytes.
* Arrivals of packets are recorded to file ps.txt.
*/
PacketScheduler ps = new PacketScheduler(4444,
 "localhost", 4445, 20971520, 2, 1480,
new long [] {100*1024, 100*1024}, "ps.txt");
// start packet scheduler
new Thread(ps).start();
}
}
