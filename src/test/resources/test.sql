create table Student(Sno varchar(10),Sname varchar(10),Sage date,Ssex varchar(10));
insert into Student values('01' , '赵雷' , str_to_date('1990-01-01','%Y-%m-%d') , '男');
insert into Student values('02' , '钱电' , str_to_date('1990-12-21','%Y-%m-%d') , '男');
insert into Student values('03' , '孙风' , str_to_date('1990-05-20','%Y-%m-%d') , '男');
insert into Student values('04' , '李云' , str_to_date('1990-08-06','%Y-%m-%d') , '男');
insert into Student values('05' , '周梅' , str_to_date('1991-12-01','%Y-%m-%d') , '女');
insert into Student values('06' , '吴兰' , str_to_date('1992-03-01','%Y-%m-%d') , '女');
insert into Student values('07' , '郑竹' , str_to_date('1989-07-01','%Y-%m-%d') , '女');
insert into Student values('08' , '王菊' , str_to_date('1990-01-20','%Y-%m-%d') , '女');

create table Course(Cno varchar(10),Cname varchar(10),Tno varchar(10));
insert into Course values('01' , '语文' , '02');
insert into Course values('02' , '数学' , '01');
insert into Course values('03' , '英语' , '03');

create table Teacher(Tno varchar(10),Tname varchar(10));
insert into Teacher values('01' , '张三');
insert into Teacher values('02' , '李四');
insert into Teacher values('03' , '王五');

create table SC(Sno varchar(10),Cno varchar(10),score tinyint);
insert into SC values('01' , '01' , 80);
insert into SC values('01' , '02' , 90);
insert into SC values('01' , '03' , 99);
insert into SC values('02' , '01' , 70);
insert into SC values('02' , '02' , 60);
insert into SC values('02' , '03' , 80);
insert into SC values('03' , '01' , 80);
insert into SC values('03' , '02' , 80);
insert into SC values('03' , '03' , 80);
insert into SC values('04' , '01' , 50);
insert into SC values('04' , '02' , 30);
insert into SC values('04' , '03' , 20);
insert into SC values('05' , '01' , 76);
insert into SC values('05' , '02' , 87);
insert into SC values('06' , '01' , 31);
insert into SC values('06' , '02' , 34);
insert into SC values('07' , '02' , 89);
insert into SC values('07' , '03' , 98);

use test;
select Sno from SC where Sno !='01' group by Sno;

use test;
select count(*) from SC where Sno='01' group by Sno;

use test;
select Sno from SC where Sno !='01' group by Sno
having count(*)=3;

use test;
select Sno from SC where Sno !='01' group by Sno
having count(*)=(select count(*) from SC where Sno='01' group by Sno);


use test;
(select Sno,Cno from SC where Sno in
                              (select Sno from SC where Sno !='01' group by Sno
                               having count(*)=(select count(*) from SC where Sno='01' group by Sno)));


use test;
select Cno from SC where Sno='01';

use test;
select Sno from
(select Sno,Cno from SC where Sno in
                             (select Sno from SC where Sno !='01' group by Sno
                              having count(*)=(select count(*) from SC where Sno='01' group by Sno))) as t1
        inner join (select Cno from SC where Sno='01') as t2
on t1.Cno = t2.Cno
group by Sno
having count(*)=(select count(*) from SC where Sno='01');


use test;
(select Sno from
    (select Sno,Cno from SC where Sno in
                                  (select Sno from SC where Sno !='01' group by Sno
                                   having count(*)=(select count(*) from SC where Sno='01' group by Sno))) as t1
        inner join (select Cno from SC where Sno='01') as t2
                   on t1.Cno = t2.Cno
 group by t1.Sno
 having count(*)=(select count(*) from SC where Sno='01')
);

# 从分数表选中和01号有相同数目课程的学生编号
# 选中上一步学生的编号和课程作为t1
# 把01号的课程作为t2
# 根据课程编号内连接t1和t2
# 选出上一步内连接后的学生编号
# 根据学生编号分组
# 选出组内个数等于01号课程数的学生编号
# 从学生表内选出上一步学生编号的信息


use test;
select * from Student where Sno in
(select Sno from
    (select Sno,Cno from SC where Sno in
                                  (select Sno from SC where Sno !='05' group by Sno
                                   having count(*)=(select count(*) from SC where Sno='05' group by Sno))) as t1
        inner join (select Cno from SC where Sno='05') as t2
                   on t1.Cno = t2.Cno
 group by t1.Sno
 having count(*)=(select count(*) from SC where Sno='05')
);

use test;
select * from Student where Sno in
                            (select Sno from
                                (select Sno,Cno from SC where Sno in
                                                                  (select Sno from SC where Sno !='01' group by Sno
                                                                   having count(*)=(select count(*) from SC where Sno='01' group by Sno))) as t1
                                    inner join (select Cno from SC where Sno='01') as t2
                                               on t1.Cno = t2.Cno
                             group by t1.Sno
                             having count(*)=(select count(*) from SC where Sno='01')
                            );

select distinct t.* from Student t
where t.sno not in (
    select sno from SC where cno != all(select cno from SC where sno='01')
) and t.sno in (select sno from SC) and sno!='01';





use test;
select *
from Student
where Sno in
      (select Sno
       from (select Sno, Cno
             from SC
             where Sno in
                   (select Sno
                    from SC
                    where Sno != '01'
                    group by Sno
                    having count(*) = (select count(*) from SC where Sno = '01' group by Sno))) as t1
                inner join (select Cno from SC where Sno = '01') as t2
                           on t1.Cno = t2.Cno
       group by t1.Sno
       having count(*) = (select count(*) from SC where Sno = '01')
      );
