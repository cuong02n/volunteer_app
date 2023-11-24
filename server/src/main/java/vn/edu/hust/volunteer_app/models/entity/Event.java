package vn.edu.hust.volunteer_app.models.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
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
        NOT_VERIFY(0),
        VERIFIED(1),
        SUSPENDED(2);
        final int code;

        STATUS(int code) {
            this.code = code;
        }

        public int getValue() {
            return code;
        }
    }

    @Id
    @GeneratedValue
    @Column(name = "id")
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "content", nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(name = "target", nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer target;

    @Column(name = "fanpage_id", nullable = false)
    private Integer fanpage_id;

    @Column(name = "status", nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer status;

    @Column(name = "image", length = 255)
    private String image;
    // Các getters và setters

}
