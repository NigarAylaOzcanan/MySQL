-- Bu dosya, örnek `employees` tablosunu hedefleyen çeşitli SQL sorgularını içerir.
-- Bu sorgular, veritabanı şeması ve gereksinimlerinize bağlı olarak uyarlanabilir.

use employees;
SELECT * FROM `employees`.`departments`;
SELECT * FROM `employees`.`dept_emp`;
SELECT * FROM `employees`.`dept_manager`; 
SELECT * FROM `employees`.`employees`;
SELECT * FROM `employees`.`salaries`;
SELECT * FROM `employees`.`titles`;

-- Bu sorgu, başlıklar tablosundan benzersiz başlık değerlerini alır ve her başlığı yalnızca bir kez listeleyerek yinelenen değerleri ortadan kaldırır. 
-- DISTINCT anahtar kelimesi, sonucun yinelenen değerleri elemine ettiğinden, her başlık sadece bir kez görünür. 
-- Bu şekilde, yalnızca başlık bilgisi içeren bir sonuç kümesi elde edersiniz.
SELECT DISTINCT title FROM titles; 

-- TÜM SORGULAR BU DOSYA İÇİNDEKİ YORUMLARDA AÇIKLANDI
-- SELECT DURUMLARI;
SELECT first_name,last_name FROM employees;
-- yıldız tüm demektir
SELECT * FROM employees; -- YILDIZ BİZE TÜM SÜTUNLARDAN TÜM VERİYİ VERECEKTİR

-- WHERE KOŞULU: GETİRMEK İSTEDİĞİMİZ KOŞULLARI AYARLAMAMIZI SAĞLAR.
SELECT * FROM employees WHERE first_name='georgi';
SELECT * FROM employees WHERE first_name="elvis";

-- OPERATÖRLER : VE (AND), İÇİNDE (IN), VEYA (OR), GİBİ (LIKE), ARASINDA (BETWEEN), İÇİNDE DEĞİL (NOT IN) ;
-- VE : KOD BLOĞU KOŞULUNDA İKİ DURUMU MANTIKSAL OLARAK BİRLEŞTİRMEYE İZİN VERİR. TÜM KOŞULLARIN DOĞRU OLMASI GEREKİR;
-- ÖRNEK:
SELECT * FROM employees WHERE first_name='denis' AND gender='m';
SELECT * FROM employees WHERE first_name='kellie' AND gender='f';

-- YALNIZCA BİR VEYA DAHA FAZLA KOŞULUN DOĞRU OLMASI GEREKİYORSA "VEYA" OPERATÖRÜ KULLANILIR.
-- ÖRNEK:
SELECT * FROM employees WHERE first_name='denis' OR first_name ='elvis';
SELECT * FROM employees WHERE first_name='kellie' OR first_name='aruna';

-- OPERATÖR ÖNCELİĞİ : EĞER AYNI BLOKTA VE + VEYA KULLANIYORSAK, 'VE' İLK UYGULANIR; 'VEYA' İKİNCİ UYGULANIR.
SELECT * FROM employees WHERE first_name='denis' AND gender='m' OR gender='f';
-- YUKARIDAKİ SORGU OPERATÖR ÖNCELİĞİ NEDENİYLE DOĞRU CEVABI VERMEZ.  DOĞRU ÇIKTIYI ALMAK İÇİN
-- PARANTEZ KULLANIRIZ.
SELECT * FROM employees WHERE first_name='denis' AND (gender='m' OR gender='f');
SELECT * FROM employees WHERE gender='f' AND (first_name='kellie' OR first_name='aruna');

-- İÇİNDE (IN): 2 VEYA DAHA FAZLA KOŞULU KARŞILAMAMIZ GEREKTİĞİNDE KULLANIRIZ.
-- NORMAL SORGU
SELECT * FROM employees WHERE first_name='denis' OR first_name='aruna' OR first_name='kellie';
-- IN OPERATÖRÜ İLE BİRLİKTE
SELECT * FROM employees WHERE first_name IN('denis','kellie','aruna');
-- IN OPERATÖRÜ, ÇOKLU KOŞULLU SORGULARDA OR'DAN DAHA HIZLIDIR.
SELECT * FROM employees WHERE first_name IN('denis','elvis');
-- EĞER BİRŞEYİ ATLAYARAK ÇOKLU KOŞULLU SORGU KULLANMAK İSTİYORSANIZ, NOT IN KULLANIRIZ.
-- ÖRNEK: İLK ADI DENİS, KELLİE VEYA ARUNA OLMAYAN BİR SORGU
SELECT * FROM employees WHERE first_name NOT IN('denis','kellie','aruna');
SELECT * FROM employees WHERE first_name NOT IN('john','mark','jacob');

--	LIKE ve NOT LIKE Operatörleri: Belirli bir kalıbı aramak için LIKE operatörünü kullanırız.
--	Örneğin: "MAR" ile başlayan adı olan veya soyadı "OVIC" ile biten çalışanların tüm verilerini bulma.
SELECT * FROM employees WHERE first_name LIKE 'MAR%';
SELECT * FROM employees WHERE last_name LIKE '%OVIC';
-- % İŞARETİNİN ALINAN KARAKTERLERİN ALT DİZİSİNİ GÖSTERMEK İÇİN KULLANILDIĞINI UNUTMAYIN.
-- LIKE VE NOT LIKE TEMELDE KALIPLAMA EŞLEŞTİRMEK İÇİN KULLANILIR.
 
 -- ARASINDA (BETWEEN): DEĞERİN AİT OLDUĞU ARALIĞI BELİRTMEYE YARDIMCI OLUR. BU YÜZDEN HER ZAMAN AND İLE KULLANILIR 
 -- ÖRNEK:
 SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '2000-01-01';
 SELECT * FROM salaries WHERE salary BETWEEN 66000 AND 77000;
 SELECT * FROM employees WHERE emp_no NOT BETWEEN 10004 AND 10012;
 SELECT * FROM departments WHERE dept_no BETWEEN 'd003' AND 'd006';
 
 -- NOT NULL KOŞULU, BİR SÜTUNDAN NULL OLMAYAN DEĞERLERİ ALMAK İÇİN KULLANILIR.
 SELECT first_name FROM employees WHERE first_name IS NOT NULL;
 SELECT dept_name FROM departments WHERE dept_name IS NOT NULL;
 
 -- DISTINCT : BENZERSİZ DEĞERLER İSTİYORSAK
 SELECT DISTINCT gender FROM employees;
 SELECT DISTINCT hire_date FROM employees;
 
 -- SAYIM (COUNT): BİR SÜTUNDAN NON NULL DEĞERLERİ SAYAR.
 SELECT COUNT(emp_no) FROM employees;
 -- DISTINCT anahtar kelimesi, COUNT ile birlikte kullanıldığında, tekrarlanan değerleri saymamasını sağlar. Sadece her değeri bir kez sayar.
 -- COUNT fonksiyonu için DISTINCT anahtar kelimesi, fonksiyon isminin önünde değil, parantezlerin içinde yazılır.
 SELECT COUNT(DISTINCT first_name) FROM employees;
 SELECT COUNT(salary) FROM salaries WHERE salary>=100000;
 SELECT COUNT(*) FROM employees;
 
 -- ORDER BY : BU KOŞUL VERİLEN SORGUYU BELİRTİLEN PARAMETREYLE SIRALAR.
 SELECT * FROM employees ORDER BY first_name;
 SELECT * FROM employees ORDER BY hire_date;
 
 -- GROUP BY:  SQL'DE ÇALIŞIRKEN, SONUÇLAR BELİRLİ BİR ALANA VEYA ALANLARA GÖRE GRUPLANDIRILABİLİR.
 -- BUNU GROUP BY İLE YAPARIZ. GROUP BY, WHERE'DEN HEMEN SONRA VE ORDER BY'DEN HEMEN ÖNCE YERLEŞTİRİLMELİDİR. 
 -- ÖRNEK OLARAK, HER BİR ADIN KAÇ KEZ GELDİĞİNİ BİLMEMİZİ İSTERSEK, 
 -- BU GRUP BY İLE YAPILABİLİR. 
 -- KATI BİR KURAL, Eğer COUNT fonksiyonunu GROUP BY ile birlikte kullanacaksak, SELECT ifadesinde saymak istediğimiz sütunu GROUP BY ifadesinden önce belirtmeliyiz.
 -- ÖRNEK:
SELECT COUNT(first_name) FROM employees GROUP BY first_name;
-- BU, ADLARIN SAYISINI ALIYORUZ VE SIRAYA KOYUYORUZ
SELECT first_name, COUNT(first_name) FROM employees GROUP BY first_name ORDER BY first_name DESC;

-- AS : AS, SORGU SONUCUNDA KARŞIMIZA ÇIKAN SÜTUN ADINI İSTEDİĞİMİZ GİBİ GÖRMEK (DEĞİŞTİRMEK) İÇİN KULLANILIR.
SELECT first_name AS names_people, COUNT(first_name) AS names_count FROM employees GROUP BY first_name ORDER BY first_name;
SELECT salary, COUNT(emp_no) AS emp_with_same_salary FROM salaries WHERE salary>80000 GROUP BY salary ORDER BY salary;

-- HAVING: HAVING WHERE GİBİ AMA GRUP BY VE ORDER BY ARASINDA KULLANILIR.
-- ÖRNEK: İLK ADLARI 250'DEN FAZLA OLAN TÜM İLK ADLARI BULUN. 
SELECT first_name,COUNT(first_name) AS names_count FROM employees GROUP BY first_name
HAVING COUNT(first_name)>250 ORDER BY first_name;
-- WHERE'DE, HAVING KULLANILAN KÜMESEL FONKSİYONLAR KULLANILAMAZKEN, HAVING İLE KULLANILABİLİR.
SELECT first_name , COUNT(first_name) FROM employees WHERE hire_date>'1999-01-01' GROUP BY first_name
HAVING COUNT(first_name)<200 ORDER BY first_name;
-- YUKARIDAKİ SORGU, 1 OCAK 1999'DAN SONRA İŞE ALINAN VE ADI 200'DEN AZ OLAN TÜM ÇALIŞANLARI SEÇER.

-- EĞER KÜMESEL FONKSİYONLAR KULLANIYORSANIZ HAVING KULLANIN, GENEL SORGULAR İÇİN WHERE KULLANIN.
-- ÖRNEK:
-- HAVING Kullanımı: COUNT() işlevini kullandığımız için HAVING kullanmalıyız.
SELECT first_name, COUNT(first_name) FROM employees GROUP BY first_name
HAVING COUNT(first_name) > 100;
-- WHERE Kullanımı: Bu gibi genel bir sorgu için WHERE kullanılmalıdır.
SELECT * FROM employees WHERE hire_date > '2023-01-01';

-- WHERE ve HAVING Arasındaki Farklar:

-- Kullanım Yeri: WHERE satırlar üzerinde, HAVING ise gruplar üzerinde kullanılır.
-- Zamanlama: WHERE koşulu, GROUP BY'dan önce, HAVING koşulu ise GROUP BY'dan sonra çalıştırılır.
-- Fonksiyon Kullanımı: WHERE koşulunda kullanılan fonksiyonlar herhangi bir kısıtlamaya tabi değildir. HAVING koşulunda ise sadece kümesel fonksiyonlar kullanılabilir. Kümesel fonksiyonlar, birden fazla satır üzerinde işlem yapan fonksiyonlardır (COUNT, SUM, AVG, MIN, MAX gibi).

-- SINIRLAR : BELİRLİ SAYIDA SATIR İSTİYORSAK VEYA ÇIKTIYI BELİRLİ DEĞERLERLE SINIRLAMAK İSTİYORSANIZ LİMİT KULLANIN.
-- ÖRNEK:
SELECT * FROM employees LIMIT 100;

-- -------------------------------------------- KATILIMLAR (JOINS)----------------------------------------

-- İÇ KATILIMLAR (INNER JOINS) : AYNI SÜTUN(LAR)A SAHİP İKİ TABLO ARASINDAKİ KESİŞMEDİR.
USE employees;
SELECT e.emp_no, e.first_name, e.last_name, d.dept_no,e.hire_date FROM employees e
INNER JOIN dept_manager d ON e.emp_no=d.emp_no ORDER BY e.emp_no;

-- LEFT JOIN : Sol tablodan tüm satırlar seçilir, sağ tablodan ise eşleşen satırlar seçilir.
-- Eşleşmeyen satırlarda sağ tablodan değerler NULL olarak gösterilir.
-- Örnek: employees ve dept_manager tabloları emp_no sütununa göre birleştirilir. Her iki tablodan da emp_no sütununa göre eşleşen bilgiler seçilir. Eşleşmeyen satırlarda dept_no, from_date değerleri NULL olarak gösterilir.
SELECT e.emp_no,e.first_name, e.last_name, d.dept_no, d.from_date FROM employees e
LEFT JOIN dept_manager d ON e.emp_no=d.emp_no WHERE e.last_name="markovitch" ORDER BY
d.dept_no DESC,emp_no ASC; 

-- RIGHT JOIN : Sağ tablodan tüm satırlar seçilir, sol tablodan ise eşleşen satırlar seçilir.
-- Eşleşmeyen satırlarda sol tablodan değerler NULL olarak gösterilir.
-- Örnek: employees ve dept_manager tabloları emp_no sütununa göre birleştirilir. Sağ tablodan tüm satırlar seçilir. Eşleşen satırlarda emp_no, first_name, last_name, hire_date değerleri seçilir. Eşleşmeyen satırlarda emp_no'dan değerler, first_name, last_name, hire_date değerleri NULL olarak gösterilir.
SELECT e.emp_no, d.dept_no, e.first_name,e.last_name, e.hire_date FROM employees e
INNER JOIN dept_manager d ON e.emp_no=d.emp_no ORDER BY e.emp_no DESC;
--	
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date, t.title FROM employees e
INNER JOIN titles t ON e.emp_no=t.emp_no WHERE e.first_name= "margareta" AND last_name="markovitch";

-- CROSS JOIN (ÇARPAN KATILIM) : BELİRLİ BİR TABLODAN GELEN TÜM DEĞERLERİ İKİNCİ TABLODAKİ TÜM DEĞERLERLE BİRLEŞTİRİR.
-- İKİ TABLODA DA ID'LER VARSA VEYA DEĞERLERİN ÇOK FAZLA OLDUĞU BİR SENARYO İSE KULLANILIR.
 SELECT m.dept_no, m.emp_no,m.from_date,m.to_date, d.dept_no FROM dept_manager m 
 CROSS JOIN departments d WHERE d.dept_no='d009';
 
 -- İKİDEN FAZLA TABLOYU BİRLİKTE KULLANMA : AŞAMALI BİR YAKLAŞIM UYGULAYIN, ÖNCE İLK İKİ TABLOYU BİRLEŞTİRİN, SONRA DA OLUŞAN TABLOYU ÜÇÜNCÜYLE BİRLEŞTİRİN.
 SELECT e.emp_no,e.first_name, e.last_name, e.hire_date, t.title, d.from_date, dm.dept_name
 FROM employees e INNER JOIN titles t ON e.emp_no=t.emp_no
 JOIN dept_manager d ON t.emp_no=d.emp_no INNER JOIN departments dm ON
 d.dept_no=dm.dept_no ORDER BY e.emp_no;
 
 -- DÖRT TABLO KULLANARAK KOMPLEKS SORGU.
SELECT e.gender, COUNT(dm.emp_no) FROM employees e
INNER JOIN dept_manager dm ON e.emp_no=dm.emp_no GROUP BY e.gender;

-- İÇ SORGULAR (SUBQUERIES) : BÜYÜK BİR SORGUNUN İÇİNDE YER ALAN SORGULAR.
-- BUNLAR, DAHA BÜYÜK BİR SORGUNUN BİR PARÇASI OLARAK KULLANILIR.
-- SQL ENGINE (ÖRNEĞİN MYSQL CLIENT), İÇ SORGUYU İLK OLARAK İŞLER. İÇ SORGUNUN SONUÇLARI, DIŞ SORGUNUN YÜRÜTÜLMESİ İÇİN KULLANILIR.
SELECT
*FROM
dept_manager
WHERE
emp_no IN (SELECT
emp_no
FROM
employees
WHERE
hire_date BETWEEN '1990-01-01' AND '1995-01-01'); 

-- VAR (EXISTS), YOK (NOT EXISTS) : BELİRLİ SATIR DEĞERLERİNİN BİR ALTSORGUDA BULUNUP BULUNMADIĞINI KONTROL EDER.
-- BU KONTROL SATIR SATIR GERÇEKLEŞTİRİLİR.
-- BİR BOOLEAN DEĞER DÖNDÜRÜR;
SELECT * FROM employees WHERE emp_no IN(SELECT emp_no FROM titles WHERE title="assistant engineer") 
ORDER BY emp_no;
SELECT * FROM employees WHERE NOT EXISTS (SELECT emp_no FROM titles WHERE title = 'assistant engineer');
-- Bu sorgu, alt sorgu sonucunda başlık 'yardımcı mühendis' olan ve hiçbir çalışan numarası bulunmayan çalışanları getirir.
