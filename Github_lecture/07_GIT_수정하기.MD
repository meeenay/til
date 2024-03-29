# Git 추가설명 : 수정





![](images/image-20191211111917209.png)





----



## 1. commit 

> commit을 통해 이력을 확정하면 Hash 값이 부여되며, 이 값을 통해 동일한 commit인지를 확인한다



> > **hash에 대한 쉬어가는 이야기**
> >
> > 비트코인과 같은 암호화에서도 많이 사용되는 개념!
> >
> > 참고: [256 bit의 암호코드는 해킹하기가 얼마나 힘들까? ](https://www.youtube.com/watch?v=S9JGmA5_unY)



```bash
# WD 변화 x, staging area 비어있을 때 
# 즉, 변경사항이 없을 때

$ git commit
nothing to commit, working tree clean		
```



```bash
# WD 변화 O , staging area 비어있을 때 
$ git commit
On branch master
Untracked files:
        me.txt

nothing added to commit but untracked files present

```

### commit message 작성하기

> 부제: Vim 활용법

```bash
$ git add .
$ git commit 



```

* 편집모드 (i)

  * 문서편집 가능

    i를 누르면 편집모드로 바뀌면서 --끼워넣기--가 표시된다

![image-20191211093730862](images/image-20191211093730862.png)

![image-20191211093859874](images/image-20191211093859874.png)

​		작성 후 esc를 누르면 --끼워넣기가 없어지면서 명령모드로 전환



* 명령모드 (esc)
  *  dd   : 해당 줄 삭제
  * :wq  : 저장 및 종료 
    * w  : write(저장)
    * q  : quite(종료)
  * q!   :  저장없이 강제 종료
    * q  : quit
    * !   : 강제



### log 활용하기 

``` bash
$ git log
$ git log --oneline
$ git log -1
$ git log -1 --oneline
$ git log --oneline --graph
```



* HEAD : 현재 작업 하고 있는 커밋 이력 및 브랜치에 대한 포인터

  ![](images/image-20191211094733883.png)

  ```bash
  a4804c7 (HEAD -> master) add me.txt
  # 나는 현재 master 브랜치에 있고 
  # a4804c7 커밋의 상태에 있음
  ```

* 예시)

  ```bash
  a4804c7 (HEAD -> master) add me.txt
  e7cd26d (feature/signout) signout 추가개발 완료
  77ab549 (origin/master)집 - main.html
  
  # 나는 master 브랜치에서  a4804c7 커맷을 했고 
  # feature/signout 브랜치는 e7cd26d 이력이고
  # 원격저장소(original master)는 ____이력이다
  
  ```



### 직전 커밋 메세지 수정

> 아래의 명령어는 **커밋이력을 변경** 하기 때문에 조심해야 한다. 공개된 저장소에(원격 저장소) 이미 push된 이력이라면 절대 해서는 안된다.

```bash
#--------수정 전 --------#
$ git log --oneline -1
a4804c7 (HEAD -> master) add me.txt

#--------- 수정 --------#
$ git commit --amend
# Vim에 들어가서 새로 수정

#------- 수정 후 --------#
$ git log --oneline -1
7608815 (HEAD -> master) add me.txt!

#-------- 주의 --------#
# Hash번호가 변경된 것을 볼 수 있다. 따라서 원격저장소에 공유되어 있는 commit을 수정하면 다시 push and pull을 이력이 꼬이게 되는 문제가 있다. 
```







### 커밋시 특정 파일을 빠뜨렸을 때

만약, staging area에 특정 파일(현재 `omit_file.txt`)을 커밋에 실수로 포함하지 않았을 때 수정하는 법

```bash
$ git add .
$ git commit --amend
```

직전에 찍었던 commit을 변경사항을 포함 해 다시 수정해서 찍어준다.









-----



## 2. staging area





* 커밋 이력이 있는 파일을 수정한 경우 

  * working directory 상황에 있는 경우 다음의 두 가지 종류의 추천메세지가 뜬다

    * staging을 하거나
    * 지난 커밋으로 돌아가기

  * 참고: `git commit -a`

    * git commit -a : 지금까지 변화된 보든 내용을 add . 하여 한꺼번에 commit 한다

    * 주의 : 한 번도 commit된 적 없는 파일은 포함되지 않는다. (신규 파일)

    * `git commit -am {메세지내용}` : 메세지 까지 달아서 올릴 수 있다

      

  ```bash
  $ git status
  On branch master
  
  Changes not staged for commit:
  		# 수정사항을 staged로 바꾸려면
  	(use "git add <file>..." to update what will be committed)
  		# WD에 있는 수정사항을 버리고 지난 커밋 이력으로 돌아가기
  		# (커밋 이후 변경 사항을 없애버림. 
  		# 없어진 코드를 다시 살리거나, 불필요한 코드를 날리고 초기화 할때도 사용 가능)
  	(use "git restore <file>..." to discard changes in working directory)
  		modified :   2.txt
  		
  # staging area가 비어있습니다.
  # (커밋에 추가할 변화가 없다)
  no changes added to commit (use "git add" and/or "git commit -a"
    # git commit -a : 지금까지 변화된 보든 내용을 add . 하여 한꺼번에 commit 한다
    # 주의 : 한 번도 commit된 적 없는 파일은 포함되지 않는다. (신규 파일)
  
  ```



* 커밋 이력이 없는 파일인 경우 

  * staging을 하라는 명령어만 나온다 (add)

  ```bash
  $ git status
  On branch master
  
   # tracking되고 있지 않은 파일 --> commit에 한 번도 올라간 적 없는 새로운 파일
  Untracked files: 
  	(use "git add <file>..." to include in what will be committed)
  	a.txt
  	"\355\230\201\354\236\254.txt"
  	
  # 커밋 할 것도 없고 (staging area가 비어있고)
  # 트래킹 되고 있지 않는 파일도 있다
  no changes added to commit (use "git add" and/or "git commit -a")
  ```





* staging area에 있는 경우 (변화 이력을 add 하고 난 뒤)  뜨는 추천 메세지

  * add 하기 전 working directory 수준으로 돌아가는 명령어

  ```bash
  	# txt 2의 내용을 수정한 후
  $ git add 2.txt
  $ git status
  On branch master
  
  changes to be committed:
  	 (use "git restore --staged <file> ..." to unstage)
  	 	 modified :   2.txt
  ```





### add 취소하기 

* 현재 버전 명령어(2019 8월 update)

```bash
$ add restore --staged <file>
```

* 구 버전 git에서는 아래의 명령어를 사용해야 한다.	 

```bash
$ git HEAD <file>
```





### Working directory 변화 삭제하기

> git 에서는 모든 commit된 내용은 되돌릴 수 있다.
>
> 다만, 아래의 WD 내용을 삭제하는 것은 되돌릴 수 없다.

``` bash
$ git restore <file>
```

* 구버전 git에서는 아래의 명령어를 사용해야 한다

  ```bash
  $ git checkout --<file>
  ```







## Stash

> Stash는 병경사항을 임시로 저장 해놓는 공간이다. 



#### **예시상황**

```bash
1. feature branch에서 a.txt 를 변경 후 커밋
2. master branch 에서 a.txt를 수정! (add X/ commit X)
3. merge
```

```bash
$ git merge test
 # 현재 merge 명령어로 인해 덮어쓰기 될 수 있다
error: Your local changes to the following files would be overwritten by merge:
        a.txt
# 따라서 commit 하거나 stash  하라
# commit 하면 -> 이력 확정을 해서 merge시 충돌 나는 상황으로 흐르고 
# stash 해라 -> Working directory를 잠시 비워놓음
Please commit your changes or stash them before you merge.
Aborting
Updating b190969..a9535ea

```



#### Stash 관련 명령어

```bash
$ git stash # stash 공간에 저장
Saved working directory and index state WIP on master: b190969 a.txt

$ git stash list # stash 공간 내용 확인(목록)
stash@{0}: WIP on master: b190969 a.txt

$ git stash pop # stash 공간에서 적용(apply)하고 목록에서 삭제(drop)하기 (git stash apply + git stash drop 인 셈)
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   a.txt

no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (a482e196b934464ff762645b695db4cac54416ca)

```



* `git stash` 

  * 디렉토리를 비우고, 작업내용을 어딘가에 저장해 놓는다.
  * 따라서 해당 파일을 열어 놓으면 작업 전 commit상태로 돌아간다 

  ![image-20191211113415655](images/image-20191211113415655.png)



* git stash list : 임시저장 해놓은 목록

* git stash pop : 꺼내오기

![image-20191211113453967](images/image-20191211113453967.png)

#### 예시 상황 해결

```bash
$ git stash
Saved working directory and index state WIP on master: b190969 a.txt

$ git merge test
Updating b190969..a9535ea
Fast-forward
 a.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

$ git stash pop
Auto-merging a.txt
CONFLICT (content): Merge conflict in a.txt
The stash entry is kept in case you need it again.

# --> 충돌은 여전히 발생
# 충돌 해결 후 작업 이어나가기


```

```bash
# ---충돌 메모장 내용 ----# 

첫번째 내용!
<<<<<<< Updated upstream
Test branch 내용!
=======
2. master 브랜치에서 수정
>>>>>>> Stashed changes

```







## 주의사항

* .git 폴더 안에서 .git 저장소를 다시 생성하면 안된다.

