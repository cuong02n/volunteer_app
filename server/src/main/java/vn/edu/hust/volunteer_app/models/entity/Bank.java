package vn.edu.hust.volunteer_app.models.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "bank")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Bank {

    @Id
    @Column(name = "code")
    private Integer code;

    @Column(name = "name")
    private String name;

    // Constructors, getters, setters, and other methods
}
