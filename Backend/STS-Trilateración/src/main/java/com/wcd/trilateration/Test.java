package com.wcd.trilateration;

import org.apache.commons.math3.fitting.leastsquares.LevenbergMarquardtOptimizer;
import org.apache.commons.math3.fitting.leastsquares.LeastSquaresOptimizer.Optimum;
import org.apache.commons.math3.linear.RealVector;
import java.lang.Math;

public class Test {
	

	public static void main(String[] args) {
		double RSSI = -42.0;
		double RSSI0=-30.0;
		double rssiT=(RSSI0-RSSI)/40;
		double distance;
		//double n =2.5;
				
		distance = Math.pow(10,rssiT);
		double distance2= Math.pow(distance, 2);
		final RealVector linearCalculatedPosition;
		final Optimum nonLinearOptimum;
		// TODO Auto-generated method stub
		System.out.println(distance);
		System.out.println(distance2);
		   double[][] positions = new double[][]{{0,7.35}, {0,-7.35}, {0,0} };
	        double[] distances = new double[]{distance2, distance2, distance2};
	      //  double[] expectedPosition = new double[]{0.0, 2.0};
	        TrilaterationFunction trilaterationFunction = new TrilaterationFunction(positions, distances);
			LinearLeastSquaresSolver lSolver = new LinearLeastSquaresSolver(trilaterationFunction);
			NonLinearLeastSquaresSolver nlSolver = new NonLinearLeastSquaresSolver(trilaterationFunction, new LevenbergMarquardtOptimizer());

			linearCalculatedPosition = lSolver.solve();
			nonLinearOptimum = nlSolver.solve();
			//printDoubleArray("linear calculatedPosition: ", linearCalculatedPosition.toArray());
//			printDoubleArray("expectedPosition: ", expectedPosition);
			printDoubleArray("linear calculatedPosition: ", linearCalculatedPosition.toArray());
			printDoubleArray("non-linear calculatedPosition: ", nonLinearOptimum.getPoint().toArray());
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

}
