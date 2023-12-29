package vn.edu.hust.volunteer_app.models.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "event")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Event {
    public enum STATUS {
        NOT_VERIFY,
        VERIFIED;

    }

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "content", nullable = false, columnDefinition = "TEXT")
    private String content;
    @Column(name = "progress")
    private Integer progress;
    @Column(name = "target", nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer target;
    @Column(name = "start_time")
    private Long startTime;
    @Column(name = "end_time")
    private Long endTime;
    @Column(name = "fanpage_id", nullable = false)
    private Integer fanpageId;
    @Column(name = "status", nullable = false)
    @Enumerated(EnumType.STRING)
    private Event.STATUS status;
    @Column(name = "image")
    private String image;
    @Column(name = "bank")
    private String bank;
    @Column(name = "bank_account")
    private String bankAccount;

    public static Event fromRequest(Request request) {
        return Event.builder()
                .fanpageId(request.fanpageId())
                .title(request.title())
                .content(request.content())
                .progress(request.progress())
                .target(request.target())
                .startTime(request.startTime())
                .endTime(request.endTime())
                .bank(request.bank())
                .bankAccount(request.bankAccount())
                .build();
    }

    public record Request(Integer fanpageId, String title, String content, Integer progress, Integer target,
            Long startTime, Long endTime, String bank, String bankAccount) {
    }
}
