package com.wcd;

import java.util.concurrent.ExecutionException;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.wcd.data.UserService;

@SpringBootTest
class WiFiCrowdDistanceApplicationTests {
	@Autowired
	UserService fboperations;
	
	@Autowired
	TrilaterationService ts;
	
	@Test
	void contextLoads() throws InterruptedException, ExecutionException {
		System.out.println("HSADSDASDSADASDSADSDAS");
		//fboperations.getAllUser();
		ts.CalcularPoscion(0.0, 7.35, 0.0, -7.35, -14, 4.0, -30, -42);
	
	}

}
