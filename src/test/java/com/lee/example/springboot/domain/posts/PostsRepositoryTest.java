package com.lee.example.springboot.domain.posts;

import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@RunWith(SpringRunner.class)
@SpringBootTest
public class PostsRepositoryTest {

    @Autowired
    PostsRepository postsRepository;

    @After
    public void cleanup() {
        postsRepository.deleteAll();
    }

    @Test
    public void 게시글저장_불러오기() {
        // Given
        String title = "테스트 게시글";
        String content = "테스트 본문";

        postsRepository.save(Posts
                .builder()
                .title(title)
                .content(content)
                .author("1eedaegon@github.com")
                .build());
        // When
        List<Posts> postsList = postsRepository.findAll();
        // Then
        Posts posts = postsList.get(0);
        assertThat(posts.getTitle()).isEqualTo(title);
        assertThat(posts.getContent()).isEqualTo(content);
    }

    @Test
    public void BaseTimeEntity_등록() {
        // Given - 시간이 저장되었는지, 그리고 일정 시간 이후의 값인지
        LocalDateTime now = LocalDateTime.of(2021,1,1,0,0,0);
        postsRepository.save(Posts.builder()
                .title("제목")
                .content("내용")
                .author("저자")
                .build());
        // When
        List<Posts> postsList = postsRepository.findAll();
        Posts posts = postsList.get(0);
        posts.update("변경된 제목", "변경된 내용");
        // Then
        postsList = postsRepository.findAll();
        posts = postsList.get(0);
        System.out.println(">>>>>> createDate="+posts.getCreatedDate()+", modifiedDate="+posts.getModifiedDate());
        assertThat(posts.getCreatedDate()).isAfter(now);
        assertThat(posts.getModifiedDate()).isAfter(now);
    }
}
