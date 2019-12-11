# Git Branch

<u>Branch는 개발과정에서 독립적인 개발환경을 제공해준다</u>

> Git 개발 흐름에서 branch는 매우 중요하다.
>
> 독립적인 개발환경을 제공하여 동시에 다양한 작업을 진행 할 수 있도록 만들어준다. 
>
> 일반적으로 브랜치의 이름은 해당 작업을 나타낸다.



## 1. 기초명령어

* 생성 및 삭제

```bash
$ git branch # branch 목록 확인
$ git branch {브랜치 이름}  # {브랜치 이름} 생성
$ git checkout {브랜치이름} # {브랜치이름} 으로 이동
$ git branch -d {브랜치이름} # {브랜치이름} 삭제
```

* 생성 및 이동

```bash
$ git checkout -b {브랜치이름} #{브랜치이름} 생성 및 이동

```

* branch 병합

```bash
(master) $ git merge fearture
# master 브랜치로 feature 브랜치 이력 가져오기(병합)
```





## 2.  상황별 Branch Merge



>   flow ppt와 함께 볼 것





### 상황 1. fast-foward

1. feature/test branch 생성 및 이동

   

2. 작업 완료 후 commit

   ```bash
   $ touch test.txt
   $ git add .
   $ git commit -m 'test 기능 개발 완료'
   
   $ git log -- oneline
   a6aeea9 (HEAD -> feature/test) test 기능 개발 완료
   0e805b2 (testbranch, master) Testbranch - test
   fc73baa (origin/master) Add txt
   77ab549 집 - main.html
   7caee38 멀캠 - index.html
   
   ```
   
   


3. master 이동

   ```bash
   $ git checkout master
   ```
   
   ```bash
   $ git log -- oneline
   e805b2 (HEAD -> master, testbranch) Testbranch - test
   fc73baa (origin/master) Add txt
   77ab549 집 - main.html
   7caee38 멀캠 - index.html
   
   
   ```


4. master에 병합

   ```bash
   $ git merge feature/test
   $ git merge feature/test
   Updating 0e805b2..a6aeea9
   
   # Fast-forward
    test.txt | 0
    1 file changed, 0 insertions(+), 0 deletions(-)
    create mode 100644 test.txt
   
   ```
   
   


5. 결과 -> fast-foward (단순히 HEAD를 이동)

   ```bash
   $ git log --oneline
   a6aeea9 (HEAD -> master, feature/test) test 기능 개발 완료
   0e805b2 (testbranch) Testbranch - test
   fc73baa (origin/master) Add txt
   77ab549 집 - main.html
   7caee38 멀캠 - index.html
   
   ```

   

6. branch 삭제






---

### 상황 2. merge commit

내가 다른 브랜치(feature)에서 작업을 하고 있는 동안, master브랜치에서 이력이 추가적으로 발생한 경우



1. feature/signout branch 생성 및 이동

   ```bash
   $ git checkout -b feature/signout
   ```

   

2. 작업 완료 후 commit

   ```bash
   $ git signout.txt
   $ git add .
   $ git commit -m 'Complete signout'
   ```

   

3. master 이동

   ```bash
   
   ```

   

4. *master에 추가 commit 이 발생시키기!!*

   * **다른 파일을 수정 혹은 생성하세요!**

   

5. master에 병합

   

6. 결과 -> 자동으로 *merge commit 발생*

   

7. 그래프 확인하기

   

8. branch 삭제




** branch의 새 commit > master의 새 commit의 우선순위로 기록된다.

** 그래프의 순서와 실제 log 순서는 달라보일 수 있다. 그래프의 연결점 때문이다. 실제 로그의 순서가 어떻게 남았는지 알기 위해서는 git log --oneline을 사용하면 정확히 알 수 있다.

---





### 상황 3. merge commit 충돌

동시에 같은 text를 수정하는 경우 (같은 파일 수정하는 경우)

1. hotfix/text branch 생성 및 이동

   ```bash
   $ git checkout -b hotfix/text
   Switched to a new branch 'hotfix/text'
   ```

   

2. 작업 완료 후 commit

   ```bash
   # text.txt 파일 수정
   
   $ git status
   $ git add .
   $ git commit -m 'hotfix text'
   
   $ git log --oneline
   9610a15 (HEAD -> hotfix/text) hotfix text
   
   ```

   


3. master 이동

   ```bash
   $ git checkout master
   ```
   
   


4. *master에 추가 commit 이 발생시키기!!*

   * **동일 파일을 수정 혹은 생성하세요!**

   ```bash
   # 수정했던 text 파일이 비어있음. 이 파일을 수정 작성하기
   
   $ git add .
   $ git commit -m 'master text'
   ```

   

5. master에 병합

   ```bash
   (master) $ git merge hotfix/text
   Auto-merging text.txt
   CONFLICT (content): Merge conflict in text.txt
   Automatic merge failed; fix conflicts and then commit the result.
   
   student@M16041 MINGW64 ~/Desktop/멀캠/web (master|MERGING)
   ```
   
   


6. 결과 -> *merge conflict발생*

   (위의 표)
   
   


7. 충돌 확인 및 해결

   ```text
   충돌 했을 때 txt 결과 복원해서 붙여넣기
   ```
   
   ```bash
   $ git status
   On branch master
   Your branch is ahead of 'origin/master' by 9 commits.
     (use "git push" to publish your local commits)
   
   You have unmerged paths.
     (fix conflicts and run "git commit")
     (use "git merge --abort" to abort the merge)
   
   Unmerged paths:
     (use "git add <file>..." to mark resolution)
           both modified:   text.txt
   
   no changes added to commit (use "git add" and/or "git commit -a")
   
   ```
   
   


8. merge commit 진행

    ```bash
    $ git commit   # 이미 commit message가 설정되어 있음
    ```

   * vim 편집기 화면이 나타납니다.
   
   * 자동으로 작성된 커밋 메시지를 확인하고, `esc`를 누른 후 `:wq`를 입력하여 저장 및 종료를 합니다.
      * `w` : write
      * `q` : quit
      
   * 커밋이  확인 해봅시다.
   
9. 그래프 확인하기

    


10. branch 삭제

    





[Skip to content](https://github.com/edutak/TIL/edit/master/git/02_Git branch scenario.md#start-of-content)



![img](images/search-key-slash.svg)

[Pull requests](https://github.com/pulls)[Issues](https://github.com/issues)

[Marketplace](https://github.com/marketplace)

[Explore](https://github.com/explore)





 

![@meeenay](images/58674421.png) 

## Learn Git and GitHub without any code!

Using the Hello World guide, you’ll start a branch, write comments, and open a pull request.

[Read the guide](https://guides.github.com/activities/hello-world/)



-  Watch [1](https://github.com/edutak/TIL/watchers)
-  Star[0](https://github.com/edutak/TIL/stargazers)
-  Fork[0](https://github.com/edutak/TIL/network/members)

# [edutak](https://github.com/edutak)/**[TIL](https://github.com/edutak/TIL)**

[ Code](https://github.com/edutak/TIL)[ Issues 0](https://github.com/edutak/TIL/issues)[ Pull requests 0](https://github.com/edutak/TIL/pulls)[ Actions](https://github.com/edutak/TIL/actions)[ Projects 0](https://github.com/edutak/TIL/projects)[ Wiki](https://github.com/edutak/TIL/wiki)[ Security](https://github.com/edutak/TIL/security/advisories)[ Insights](https://github.com/edutak/TIL/pulse)

You’re editing a file in a project you don’t have write access to. We’ve **created a fork of this project** for you to commit your proposed changes to. Submitting a change to this file will write it to a new branch in your fork, so you can send a pull request.

[TIL](https://github.com/edutak/TIL)/[git](https://github.com/edutak/TIL/tree/master/git)/[Cancel](https://github.com/edutak/TIL/blob/master/git/02_Git branch scenario.md)

 Edit file Preview changes

​               Spaces Tabs                            2 4 8                            No wrap Soft wrap             

1

```
### 상황 1. fast-foward
```

2

```

```

3

```
1. feature/test branch 생성 및 이동
```

4

```

```

5

```
   ```bash
```

6

```
   $ git checkout -b feature/test
```

7

```
   ```
```

8

```

```

9

```
2. 작업 완료 후 commit
```

10

```

```

11

```
   ```bash
```

12

```
   $ touch test.txt
```

13

```
   $ git add .
```

14

```
   $ git commit -m 'test 기능 개발 완료'
```

15

```
   ```
```

16

```
   
```

17

```
   ```bash
```

18

```
   $ git log --oneline
```

19

```
   de7c1cf (HEAD -> feature/test) test 기능 개발 완료
```

20

```
   f653956 (testbranch, master) Testbranch -test
```

21

```
   97871d5 (origin/master) 집 - main.html
```

22

```
   c1e3b55 멀캠 - index.html
```

23

```
   ```
```

24

```

```

25

```

```

26

```
3. master 이동
```

27

```

```

28

```
   ```bash
```

29

```
   $ git checkout master
```

30

```
   ```
```

31

```
   
```

32

```
   ```bash
```

33

```
   $ git log --oneline
```

34

```
   f653956 (HEAD -> master, testbranch) Testbranch -test
```

35

```
   97871d5 (origin/master) 집 - main.html
```

36

```
   c1e3b55 멀캠 - index.html
```

37

```
   
```

38

```
   ```
```

39

```

```

40

```

```

41

```
4. master에 병합
```

42

```

```

43

```
   ```bash
```

44

```
   $ git merge feature/test
```

45

```
   Updating f653956..de7c1cf
```

46

```
   # Fast-forward
```

47

```
    test.txt | 0
```

48

```
    1 file changed, 0 insertions(+), 0 deletions(-)
```

49

```
    create mode 100644 test.txt
```

[![@meeenay](https://avatars0.githubusercontent.com/u/58674421?s=96&v=4)](https://github.com/meeenay)

### Propose file change

Commit summary

Optional extended description

Propose file change [Cancel](https://github.com/edutak/TIL/blob/master/git/02_Git branch scenario.md)

- © 2019 GitHub, Inc.
- [Terms](https://github.com/site/terms)
- [Privacy](https://github.com/site/privacy)
- [Security](https://github.com/security)
- [Status](https://githubstatus.com/)
- [Help](https://help.github.com/)



- [Contact GitHub](https://github.com/contact)
- [Pricing](https://github.com/pricing)
- [API](https://developer.github.com/)
- [Training](https://training.github.com/)
- [Blog](https://github.blog/)
- [About](https://github.com/about)