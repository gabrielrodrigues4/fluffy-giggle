import java.util.Locale;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		
		Locale.setDefault(Locale.US);
		Scanner sc = new Scanner (System.in);
		
		System.out.println("O julianaa?");
		int n = sc.nextInt();
		double[] vetor = new double[n];
		double batata = 0;
				
		for (int i=0; i<n; i++) {
			vetor[i] = sc.nextDouble();
		}
		
		for (int x=1; x<n; x++) {
			batata = vetor[x] += vetor[x-1];
		}
		
		double media = batata / n;
		System.out.println(media);
		
		sc.close();
	}

}
