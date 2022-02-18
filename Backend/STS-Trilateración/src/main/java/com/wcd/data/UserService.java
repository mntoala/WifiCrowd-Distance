package com.wcd.data;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.CollectionReference;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;

import com.google.firebase.cloud.FirestoreClient;
import com.wcd.pojo.FBInitialize;
import com.wcd.pojo.User;

@Service
public class UserService {
	@Autowired
	FBInitialize db;

	// CRUD operations

	public List<User> getAllUser() throws InterruptedException, ExecutionException {
		List<User> usList = new ArrayList<>();
		CollectionReference user = db.getFirebase().collection("data_network");
		ApiFuture<QuerySnapshot> querySnapshot = user.get();
		for (DocumentSnapshot doc : querySnapshot.get().getDocuments()) {
			User us = doc.toObject(User.class);
			usList.add(us);

		}

		return usList;

	}

	public User getUserbyMAC(String mac) throws InterruptedException, ExecutionException {
		DocumentReference user = db.getFirebase().collection("data_network").document(mac);
		ApiFuture<DocumentSnapshot> querySnapshot = user.get();
		DocumentSnapshot doc = querySnapshot.get();
		User us = doc.toObject(User.class);

		return us;

	}
}
