package edu.mum.cs.cs472.finalproject.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

public class History {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
}
