package vn.edu.hust.volunteer_backend.model;

import jakarta.persistence.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Entity
@Table(name = "fanpage")
public class Fanpage {

    static Logger logger = LoggerFactory.getLogger(Fanpage.class);
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int id;
    @Column(name = "fanpage_name")
    public String name;
    @Column(name = "leader_id")
    public int leaderId;
    @Column(name = "status")
    public int status;
    @Column(name = "create_time")
    public long create_time;
    @Column(name = "subscriber")
    public int subscriber;
}
