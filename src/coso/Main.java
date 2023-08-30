package coso;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.lang.management.ManagementFactory;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.util.Random;

public class Main {
    public static void main(String[] args) throws IOException, InterruptedException {
        if (args.length < 2 || args.length > 3) {
            System.out.println("server port");
            System.out.println("or");
            System.out.println("client port host");
        } else {
            System.out.println("kill " + args[0] + " at " + ManagementFactory.getRuntimeMXBean().getName().replaceAll("@.*", ""));
            final int port = Integer.parseInt(args[1]);
            if (args[0].equals("server")) {
                if (args.length != 2) {
                    throw new RuntimeException("server expects 1 argument port");
                }
                hostname();
                resolvedhost();
                ServerSocket servsock = new ServerSocket(port);
                System.err.println("listening on " + port);
                recieving(port, servsock);
            }
            if (args[0].equals("client")) {
                if (args.length != 3) {
                    throw new RuntimeException("client expects 2 argument port and host");
                }
                String target = args[2];
                sending(port, target);
            } else {

            }
        }
    }

    private static void recieving(int port, ServerSocket servsock) throws IOException {
        while (true) {
            long time = System.currentTimeMillis();
            try (BufferedReader br =
                         new BufferedReader(new InputStreamReader(servsock.accept().getInputStream(),
                                 StandardCharsets.UTF_8))) {
                long after = System.currentTimeMillis() - time;
                StringBuilder sb = new StringBuilder();
                while (true) {
                    String s = br.readLine();
                    if (s == null || s.trim().equals("")) {
                        break;
                    }
                    sb.append(s).append("\n");
                }
                sb.setLength(sb.length() - 1);
                System.err.println("... after " + after + "ms received on " + port);
                System.err.println("... " + sb.toString());
                System.err.println("... serving on...");
            }
        }
    }

    private static void sending(int port, String target) throws IOException, InterruptedException {
        final long id = System.currentTimeMillis();
        while (true) {
            int sleep = new Random().nextInt(5) + 1;
            try (BufferedWriter bw =
                         new BufferedWriter(new OutputStreamWriter(new Socket(target, port).getOutputStream(),
                                 StandardCharsets.UTF_8))) {
                String s =
                        "id " + id + " hello " + new Random().nextInt(100) + " to " + target + " will wait for " + sleep + "s";
                System.out.println("--- sending");
                System.out.println("--- " + s);
                bw.write(s);
                System.out.println("--- spamming on");
            }
            Thread.sleep(sleep * 1000l);
        }
    }

    private static void resolvedhost() {
        try {
            String hostname2 = InetAddress.getLocalHost().getHostName();
            System.out.println("resolved hostname: " + hostname2);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private static void hostname() {
        try {
            String hostname1 = new BufferedReader(
                    new InputStreamReader(Runtime.getRuntime().exec("hostname").getInputStream()))
                    .readLine();
            System.out.println("hostname: " + hostname1);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}