package com.bosch.leave;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class LeaveService {

    private final LeaveRepository repository;

    public LeaveService(LeaveRepository repository) {
        this.repository = repository;
    }

    public void submitRequest(LeaveRequest request) {
        request.setStatus("PENDING");
        repository.save(request);
    }

    public List<LeaveRequest> getAllRequests() {
        return repository.findAll();
    }

    public void approveRequest(Long id) {
        LeaveRequest request = repository.findById(id).orElseThrow();
        request.setStatus("APPROVED");
        repository.save(request);
    }

    public void rejectRequest(Long id) {
        LeaveRequest request = repository.findById(id).orElseThrow();
        request.setStatus("REJECTED");
        repository.save(request);
    }
}
