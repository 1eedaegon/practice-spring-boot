package com.lee.example.springboot.domain.posts;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@Entity
public class Posts {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(length = 500, nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;
    // @Entity 클래스는 Column annotation을 작성하지 않아도 기본적으로 Column으로 생성된다.
    // 기본 설정은 VARCHAR(255)이며 설정을 바꾸고 싶으면 @Column을 사용하면 된다.
    private String author;

    @Builder
    public Posts(String title, String content, String author) {
        this.title = title;
        this.content = content;
        this.author = author;
    }
}
