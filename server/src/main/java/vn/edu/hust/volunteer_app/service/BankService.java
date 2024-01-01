package vn.edu.hust.volunteer_app.service;

// BankService.java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.edu.hust.volunteer_app.models.entity.Bank;
import vn.edu.hust.volunteer_app.repository.BankRepository;

import java.util.List;
import java.util.Optional;

@Service
public class BankService {

    private final BankRepository bankRepository;

    @Autowired
    public BankService(BankRepository bankRepository) {
        this.bankRepository = bankRepository;
    }

    public List<Bank> getAllBanks() {
        return bankRepository.findAll();
    }

    public Optional<Bank> getBankByCode(Integer code) {
        return bankRepository.findById(code);
    }

    public Bank createBank(Bank bank) {
        return bankRepository.save(bank);
    }

    public Bank updateBank(Integer code, Bank updatedBank) {
        if (bankRepository.existsById(code)) {
            updatedBank.setCode(code);
            return bankRepository.save(updatedBank);
        } else {
            // Handle not found scenario
            return null;
        }
    }

    public void deleteBank(Integer code) {
        bankRepository.deleteById(code);
    }
}
