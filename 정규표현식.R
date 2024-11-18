# 소문자로 시작하는 단어 찾기
grep("^[a-z]", c("apple", "Banana", "cherry")) 

# 숫자로 시작하는 문자열 찾기
grep("^\\d", c("1apple", "Banana", "2cherry")) 

# 특정 문자(괄호)로 시작하는 문자열 찾기wsd
grep("^\\(", c("(test)", "no", "(hello)")) 



# 알파벳 문자만 포함된 경우 찾기
grep("^[[:alpha:]]+$", c("hello", "123", "world!")) 

# 공백 포함된 경우 찾기
grep("\\s", c("hello world", "nowhere", "yes here")) 

# 특정 구두점(punctuation) 제거하기
gsub("[[:punct:]]", "", "Hello, world!")



# 여러 공백을 하나로 줄이기dsdssds
gsub("\\s+", " ", "This   is   a   test")

# 줄바꿈을 특정 문자로 변경
gsub("\\n", " ", "line1\nline2\nline3")

# 탭을 공백으로 변환sdssdsa
gsub("\\t", " ", "one\ttwo\tthree")s


# 문자와 숫자가 만나는 경계를 기준으로 문자열을 나눔.
# Lookahead와 Lookbehind를 사용해 숫자-문자, 문자-숫자 경계에서 분리.
# 숫자와 알파벳 분리
strsplit("abc123def456", "(?<=\\d)(?=\\D)|(?<=\\D)(?=\\d)", perl=TRUE)

# 알파벳과 숫자 외 문자 제거
gsub("[^[:alnum:]]", "", "abc123!@#")


# 이메일 형식 찾기
grep("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}", 
     c("user@example.com", "hello", "test@domain"))

# 전화번호 형식 추출 (010-1234-5678)
grep("\\d{3}-\\d{4}-\\d{4}", c("010-1234-5678", "no phone", "123-456"))

# 날짜 형식 찾기 (yyyy-mm-dd)
grep("\\d{4}-\\d{2}-\\d{2}", c("2024-10-19", "19/10/2024", "today"))


# 대소문자 구분 없이 단어 찾기
grep("(?i)apple", c("Apple", "banana", "APPLE"), perl=TRUE)

# 특정 패턴으로 그룹화된 부분 추출
regmatches("abc123def", regexec("(\\D+)(\\d+)(\\D+)", "abc123def"))


# $, ^ 등 특수문자를 포함한 문자열 찾기
grep("\\$|\\^", c("$money", "value^", "test"))

# 백슬래시(\)가 포함된 문자열 찾기
grep("\\\\", c("C:\\path\\to\\file", "no_slash"))


# 숫자만 남기기
gsub("\\D", "", "abc123def456")

# 단어별로 분리 후, 각 단어의 길이 계산
sapply(strsplit("Hello world from R", " "), nchar)

# 괄호로 묶인 부분 추출
regmatches("(value) and (another)", gregexpr("\\([^)]*\\)", "(value) and (another)"))









# 필요한 라이브러리 설치
install.packages("rvest")

# 라이브러리 로드
library(rvest)

# 웹 페이지 URL (예시)
url <- "https://example.com"

# HTML 페이지 읽기
page <- read_html(url)

# 첫 번째 테이블 추출하기
table_data <- page %>%
  html_element("table") %>%
  html_table()

# 결과 확인
print(table_data)



all_tables <- page %>%
  html_elements("table") %>%
  html_table()

# 각 테이블 확인
print(all_tables)



# 모든 <p> 태그 내용 추출하기
paragraphs <- page %>%
  html_elements("p") %>%
  html_text()

# 결과 확인
print(paragraphs)


# 특정 클래스가 있는 <table> 태그 추출
class_table <- page %>%
  html_element("table.class-name") %>%
  html_table()

# 특정 ID가 있는 <p> 태그 추출
id_paragraph <- page %>%
  html_element("p#specific-id") %>%
  html_text()

print(class_table)
print(id_paragraph)




# <ul> 또는 <li> 태그에서 리스트 항목 추출
list_items <- page %>%
  html_elements("li") %>%
  html_text()

print(list_items)


# <div> 태그 안의 텍스트 추출하기
div_content <- page %>%
  html_elements("div") %>%
  html_text()

print(div_content)




# 테이블 먼저 시도
table_data <- page %>%
  html_elements("table") %>%
  html_table()

if (length(table_data) > 0) {
  print(table_data)
} else {
  # 테이블이 없으면 <p> 태그 추출
  paragraphs <- page %>%
    html_elements("p") %>%
    html_text()
  
  print(paragraphs)
}




