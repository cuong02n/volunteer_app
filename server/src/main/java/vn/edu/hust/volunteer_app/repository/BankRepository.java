package vn.edu.hust.volunteer_app.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.edu.hust.volunteer_app.models.entity.Bank;

public interface BankRepository extends JpaRepository<Bank, Integer> {
    // Additional query methods can be added if needed
}