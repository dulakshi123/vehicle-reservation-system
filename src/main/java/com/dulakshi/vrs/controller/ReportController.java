package com.dulakshi.vrs.controller;

import com.dulakshi.vrs.dto.ReportDTO;
import com.dulakshi.vrs.service.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/report")
@RequiredArgsConstructor
public class ReportController {
    private final ReportService reportService;

    @GetMapping("/overall")
    public ResponseEntity<ReportDTO> overallReport() {
        return ResponseEntity.ok(reportService.fetchReport());
    }
}
