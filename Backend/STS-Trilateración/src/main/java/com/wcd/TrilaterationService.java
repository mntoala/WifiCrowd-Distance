package com.wcd;

import org.apache.commons.math3.fitting.leastsquares.LeastSquaresOptimizer.Optimum;
import org.apache.commons.math3.fitting.leastsquares.LevenbergMarquardtOptimizer;
import org.apache.commons.math3.linear.RealMatrix;
import org.apache.commons.math3.linear.RealVector;
import org.apache.commons.math3.linear.SingularMatrixException;
import org.springframework.stereotype.Service;

import com.wcd.pojo.TrilaterationResponse;
import com.wcd.trilateration.LinearLeastSquaresSolver;
import com.wcd.trilateration.NonLinearLeastSquaresSolver;
import com.wcd.trilateration.TrilaterationFunction;
import org.apache.commons.math3.util.Precision;

@Service
public class TrilaterationService {

	public TrilaterationResponse CalcularPoscion(double coordXAp1, double coordYAp1, double coordXAp2, double coordYAp2,
			int rssi0, double n, int rssi1, int rssi2) {

		// Modelo matemático de Canal PATH LOSS
		// RSSI=-10nlog(d/d0)+rssi0
		// double rssi0 = -14.0;// Valor promedio de RSSI a una distancia d0/ d0=1
		// double n = 4.0; // factor de atenuación

		// double rssi1 = RSSI CLIENTE;
		double rssiT1 = (rssi0 - rssi1) / (10 * n); // RSSI a distancia

		// double rssi2 = NEARBY RSSI
		double rssiT2 = (rssi0 - rssi2) / (10 * n); // RSSI a distancia

		double distance1 = Math.pow(10, rssiT1); // Distancia AP cliente conectado
		double distance1_2 = Math.pow(distance1, 2); // Distancia al cuadrado

		double distance2 = Math.pow(10, rssiT2); // Distancia AP2 a cliente
		double distance2_2 = Math.pow(distance2, 2); // Distancia al cuadrado
		
		
		final RealVector linearCalculatedPosition;
		final Optimum nonLinearOptimum;
		// TODO Auto-generated method stub
		 //System.out.println(distance1_2);
		 //System.out.println(distance2_2);

		double[][] positions = new double[][] { { coordXAp1, coordYAp1 }, { coordXAp2, coordYAp2 } };
		double[] distances = new double[] { distance1, distance2 };
		double[] expectedPosition = new double[]{0.0, 2.0};
		double acceptedDelta=0.0001;
		System.out.println("Distancia1: " + distances[0]);
		System.out.println("Distancia2:  " + distances[1]);
		
		
		TrilaterationFunction trilaterationFunction = new TrilaterationFunction(positions, distances);
		LinearLeastSquaresSolver lSolver = new LinearLeastSquaresSolver(trilaterationFunction);
		NonLinearLeastSquaresSolver nlSolver = new NonLinearLeastSquaresSolver(trilaterationFunction,
				new LevenbergMarquardtOptimizer());

		linearCalculatedPosition = lSolver.solve();
		nonLinearOptimum = nlSolver.solve(); 
		
		StringBuilder output = new StringBuilder();
		printDoubleArray("expectedPosition: ", expectedPosition);
		printDoubleArray("linear calculatedPosition: ", linearCalculatedPosition.toArray());
		printDoubleArray("non-linear calculatedPosition: ", nonLinearOptimum.getPoint().toArray());
		output.append("numberOfIterations: ").append(nonLinearOptimum.getIterations()).append("\n");
		output.append("numberOfEvaluations: ").append(nonLinearOptimum.getEvaluations()).append("\n");
		try {
			RealVector standardDeviation = nonLinearOptimum.getSigma(0);
			printDoubleArray("standardDeviation: ", standardDeviation.toArray());
			output.append("Norm of deviation: ").append(standardDeviation.getNorm()).append("\n");
			RealMatrix covarianceMatrix = nonLinearOptimum.getCovariances(0);
			output.append("covarianceMatrix: ").append(covarianceMatrix).append("\n");
		} catch (SingularMatrixException e) {
			System.err.println(e.getMessage());
		}

		System.out.println(output.toString());
		/////////////////////////
		
		/*
		 * double[] calculatedPosition = nonLinearOptimum.getPoint().toArray(); for (int
		 * i = 0; i< calculatedPosition.length; i++) { assertEquals(expectedPosition[i],
		 * calculatedPosition[i], acceptedDelta);
		 */
		
		///////////////////////////////////////////	
		double[] puntos = nonLinearOptimum.getPoint().toArray();

		TrilaterationResponse posicion = new TrilaterationResponse();
		
		posicion.setCoordenadaX(Precision.round(puntos[0], 2));
		posicion.setCoordenadaY(Precision.round(puntos[1], 2));
		
		System.out.println(posicion.getCoordenadaX());
		System.out.println(posicion.getCoordenadaY());

		return posicion;

	}

	private static void printDoubleArray(String tag, double[] values) {
		StringBuilder output = new StringBuilder();
		output.append(tag);
		for (double p : values) {
			output.append(p).append(" ");
		}
		output.append("\n");
		System.out.println(output);
	}

	/*
	 * private void outputResult() { output = new StringBuilder();
	 * printDoubleArray("expectedPosition: ", expectedPosition);
	 * printDoubleArray("linear calculatedPosition: ",
	 * linearCalculatedPosition.toArray());
	 * printDoubleArray("non-linear calculatedPosition: ",
	 * nonLinearOptimum.getPoint().toArray());
	 * output.append("numberOfIterations: ").append(nonLinearOptimum.getIterations()
	 * ).append("\n");
	 * output.append("numberOfEvaluations: ").append(nonLinearOptimum.getEvaluations
	 * ()).append("\n"); try { RealVector standardDeviation =
	 * nonLinearOptimum.getSigma(0); printDoubleArray("standardDeviation: ",
	 * standardDeviation.toArray());
	 * output.append("Norm of deviation: ").append(standardDeviation.getNorm()).
	 * append("\n"); RealMatrix covarianceMatrix =
	 * nonLinearOptimum.getCovariances(0);
	 * output.append("covarianceMatrix: ").append(covarianceMatrix).append("\n"); }
	 * catch (SingularMatrixException e) { System.err.println(e.getMessage()); }
	 * 
	 * System.out.println(output.toString()); }
	 */

	/*
	 * private void compareExpectedAndCalculatedResults() { double[]
	 * calculatedPosition = nonLinearOptimum.getPoint().toArray(); for (int i = 0; i
	 * < calculatedPosition.length; i++) { assertEquals(expectedPosition[i],
	 * calculatedPosition[i], acceptedDelta); } }
	 */

}
