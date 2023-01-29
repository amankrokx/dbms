import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.InputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;

class TCPS {
    public static void main(String[] args) throws Exception {
        ServerSocket serverSocket = new ServerSocket(4000);
        System.out.println("Server ready for connection");
        Socket socket = serverSocket.accept();
        System.out.println("Connection established and waiting for file");

        Scanner fileNameScanner = new Scanner(socket.getInputStream());
        String fileName = fileNameScanner.nextLine();

        File file = new File(fileName);
        FileInputStream fileInputStream = new FileInputStream(file);
        OutputStream outputStream = socket.getOutputStream();

        byte[] buffer = new byte[(int)file.length()];
        int count;
        while ((count = fileInputStream.read(buffer)) > 0) {
            outputStream.write(buffer, 0, count);
        }

        fileInputStream.close();
        socket.close();
        serverSocket.close();
        fileNameScanner.close();
        outputStream.close();
    }
}

class TCPC {
    public static void main(String[] args) throws Exception {
        Socket socket = new Socket("127.0.0.1", 4000);
        System.out.println("Enter the filename");

        Scanner scanner = new Scanner(System.in);
        String fileName = scanner.nextLine();

        OutputStream outputStream = socket.getOutputStream();
        outputStream.write((fileName + "\n").getBytes());

        InputStream inputStream = socket.getInputStream();
        byte[] buffer = new byte[1024];
        int count;
        while ((count = inputStream.read(buffer)) > 0) {
            System.out.write(buffer, 0, count);
        }

        scanner.close();
        socket.close();
        outputStream.close();
        inputStream.close();
    }
}
