package com.wcd;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.wcd.data.UserService;
import com.wcd.pojo.TrilaterationRequest;
import com.wcd.pojo.TrilaterationResponse;
import com.wcd.pojo.User;

@RestController
public class TrilaterationAPI {
	@Autowired
	UserService usServ;
	@Autowired
	TrilaterationService serv;
	
	@GetMapping("/userInfo/{mac}")
	public User getUserInfo(@PathVariable("mac") String  MAC) throws Exception {
		return usServ.getUserbyMAC(MAC);
		
		
	}
	@PostMapping("/trilateration")
	public TrilaterationResponse obtenerPosicion(@RequestBody TrilaterationRequest r) {
		return serv.CalcularPoscion(r.getCoordXAp1(), r.getCoordYAp1(), r.getCoordXAp2(), r.getCoordYAp2(), r.getRssi0(), r.getN(), r.getRssi1(), r.getRssi2());
		
	} 
	
	
	
	
	
}
