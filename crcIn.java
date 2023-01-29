import java.util.zip.CRC32;

class CRC {
    public static void main (String []args) {
        CRC32 crc = new CRC32();
        String msg = "this is message";
        byte arr[] = msg.getBytes();
        crc.update(arr);
        System.out.println(crc.getValue());
        return;
    }
}