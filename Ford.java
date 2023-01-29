// bellman ford

import java.util.*;

class Ford {
    static int V;
    static int [][]graph;
    static int []distance;

    public static void main (String []args) {
        Scanner cin = new Scanner(System.in);
        System.out.println("Enter no. of vertices (use 69 for no edge) :");
        V = cin.nextInt();
        graph = new int[V][V];
        distance = new int [V];

        System.out.println("Enter adj matrix :");
        for (int i = 0; i < V; i++) {
            for (int j = 0; j < V; j++) {
                graph[i][j] = cin.nextInt();
                if (graph[i][j] == 69) graph[i][j] = Integer.MAX_VALUE;
                else if (i == j && graph[i][j] != 0) {
                    System.out.println("Negative cycle found !");
                    return;
                }
            }
        }

        System.out.println("Enter source vertex : ");
        int src = cin.nextInt();
        bellman(src);-
    }

    public static void bellman (int src) {
        Arrays.fill(distance, Integer.MAX_VALUE);
        distance[src] = 0;

        for (int i = 0; i < V - 1; i++)
            for (int j = 0; j < V; j++)
                for (int k = 0; k < V; k++)
                    if (distance[j] != Integer.MAX_VALUE && graph[j][k] != Integer.MAX_VALUE && distance[j] + graph[j][k] < distance[k])
                        distance[k] = distance[j] + graph[j][k];

        for (int i = 0; i < V - 1; i++)
            for (int j = 0; j < V; j++)
                if (distance[i] + graph[i][j] < distance[j]) {
                    System.out.println("Negatice cycle found !");
                    return;
                }

        System.out.println("Distance vector is : ");
        for (int i = 0; i < V; i++)
            System.out.println(distance[i] + ",");
    }
}