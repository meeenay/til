# 탬플릿을 활용해 git page 게시하기



START BOOTSTRAP

- 부트스트랩을 이용해 만든 탬플릿이 있는 곳

![image-20191210094743836](C:\Users\student\AppData\Roaming\Typora\typora-user-images\image-20191210094743836.png)





Resume 탬플릿을 활용해 볼 예정 

* 다운로드 후 바탕화면에 저장
* repository 생성 (meenay.github.io)



Github pages의 기능

* 약속대로 포스팅의 이름을 github.io로만 설정해준다면, 원하는 페이지를 띄워준다는 의미



명령어

1. git init : 연결을 해주기 
2. 새로운 reposit원격저장소로 업로드하기









Open with code

* index.html : 처음 화면에 보이는 html 









# 집과 등원 작업시 충돌 상황들



집에서 다음과 같은 방법으로 데이터를 다운로드 받는다

```bash
$ git clone https://github.com/meeenay/mulcam-scenario.git
Cloning into 'mulcam-scenario'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 3 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.

student@M16041 MINGW64 ~/Desktop/집
$ cd mulcam-scenario/

student@M16041 MINGW64 ~/Desktop/집/mulcam-scenario (master)
$ git log --oneline
7caee38 (HEAD -> master, origin/master, origin/HEAD) 멀캠 - index.html

student@M16041 MINGW64 ~/Desktop/집/mulcam-scenario (master)
$ git remote -v
origin  https://github.com/meeenay/mulcam-scenario.git (fetch)
origin  https://github.com/meeenay/mulcam-scenario.git (push)

student@M16041 MINGW64 ~/Desktop/집/mulcam-scenario (master)
$ ^C

student@M16041 MINGW64 ~/Desktop/집/mulcam-scenario (master)
$ touch main.html

student@M16041 MINGW64 ~/Desktop/집/mulcam-scenario (master)
$ git add .

student@M16041 MINGW64 ~/Desktop/집/mulcam-scenario (master)
$ git commit -m '집 - main.html'
[master 77ab549] 집 - main.html
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 main.html

student@M16041 MINGW64 ~/Desktop/집/mulcam-scenario (master)
$ git log
commit 77ab5494fc3d6d4336954df6786b9ef2781fb154 (HEAD -> master)
Author: aiminnng@gmail.com <meenay>
Date:   Tue Dec 10 11:21:19 2019 +0900

    집 - main.html

commit 7caee38f7246d25f0adae1176e80a9136a7bdcde (origin/master, origin/HEAD)
Author: aiminnng@gmail.com <meenay>
Date:   Tue Dec 10 11:15:19 2019 +0900

    멀캠 - index.html

student@M16041 MINGW64 ~/Desktop/집/mulcam-scenario (master)
$ git push origin master
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 8 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 247 bytes | 247.00 KiB/s, done.
Total 2 (delta 0), reused 0 (delta 0)
To https://github.com/meeenay/mulcam-scenario.git
   7caee38..77ab549  master -> master

student@M16041 MINGW64 ~/Desktop/집/mulcam-scenario (master)



```

