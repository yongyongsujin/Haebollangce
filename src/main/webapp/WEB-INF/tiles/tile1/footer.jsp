<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	.Footer_footer {
    width: 100%;
    padding: 80px 0 116px;
    background-color: #f4f4f4;
    font-family: Pretendard
}

@media screen and (max-width: 900px) {
    .Footer_footer {
        box-sizing:border-box;
        background-color: #f4f4f4;
        padding: 28px 20px 119px
    }
}

.Footer_container {
    width: 100%;
    max-width: 1189px;
    display: flex;
    justify-content: space-between;
    margin: 0 auto;
    box-sizing: border-box;
    position: relative
}

.Footer_container div p a {
    text-decoration: none;
    color: #000
}

@media screen and (max-width: 900px) {
    .Footer_container {
        width:100%;
        display: grid;
        margin: 0 auto;
        box-sizing: border-box;
        position: relative
    }

    .Footer_info {
        grid-column: 1
    }
}

.Footer_info__subject {
    font-size: 14px;
    font-weight: 700;
    line-height: 1.43;
    color: #666
}

@media screen and (max-width: 900px) {
    .Footer_info__subject {
        font-size:14px;
        font-weight: 700;
        line-height: 1.43
    }
}

.Footer_info__content {
    font-size: 14px;
    font-weight: 700;
    line-height: 1.43;
    color: #000;
    margin-top: 12px
}

@media screen and (max-width: 900px) {
    .Footer_sns {
        grid-column:2
    }
}

.Footer_sns__subject {
    font-size: 14px;
    font-weight: 700;
    line-height: 1.43;
    color: #666
}

.Footer_sns__content {
    font-size: 14px;
    font-weight: 700;
    line-height: 1.43;
    color: #000;
    margin-top: 12px
}

.Footer_company {
    margin-top: 0
}

@media screen and (max-width: 900px) {
    .Footer_company {
        grid-column:1/span 2;
        margin-top: 40px
    }
}

.Footer_company__title {
    font-size: 14px;
    font-weight: 700;
    line-height: 1.43;
    color: #666
}

.Footer_company__content {
    font-size: 12px;
    line-height: 1.5;
    color: #666;
    margin-top: 8px
}

.Footer_company__info {
    margin-top: 22px;
    color: #000;
    font-size: 12px;
    line-height: 1.5
}

@media screen and (max-width: 900px) {
    .Footer_company__info {
        margin-top:8px
    }
}

.Footer_kakaoLink__1y_id {
    color: #666!important;
    text-decoration: underline!important
}

.policy_container___Ljpp {
    margin: 14px auto 200px;
    padding-left: 20px;
    padding-right: 20px;
    font-family: Noto Sans KR
}

.policy_container___Ljpp h4 {
    margin-top: 30px
}

.policy_container___Ljpp p {
    line-height: 2
}

.policy_container___Ljpp header {
    height: 50px
}

.policy_container___Ljpp header .policy_menu__qDNwf {
    display: none
}

.policy_container___Ljpp .policy_title__At39F {
    font-size: 20px;
    line-height: 1.2;
    letter-spacing: -.8px;
    text-align: center;
    color: #080606
}

.policy_container___Ljpp .policy_back-btn__FIANP {
    position: absolute;
    top: 14px;
    left: 20px;
    cursor: pointer
}

</style>
 
<footer class="Footer_footer">
      <div class="Footer_container">
          <div class="Footer_info">
              <p class="Footer_info__subject">해볼랑스 정보</p>
              <p class="Footer_info__content">
                  <a href="/notice/list.html">공지사항</a>
              </p>
              <p class="Footer_info__content">
                  <a href="/event/list.html">이벤트</a>
              </p>
              <p class="Footer_info__content">
                  <a href="/FAQ/list.html">자주 묻는 질문</a>
              </p>
              <p class="Footer_info__content">
                  <a href="/notice/detail.html?id=311" target="_blank">제휴 및 입점 문의</a>
              </p>
              <p class="Footer_info__content">
                  <a href="https://people.munto.kr/" target="_blank" rel="noreferrer">채용</a>
              </p>
          </div>
          <div class="Footer_sns">
              <p class="Footer_sns__subject">소셜 미디어</p>
              <p class="Footer_sns__content">
                  <a href="" target="_blank" rel="noreferrer">인스타그램</a>
              </p>
              <p class="Footer_sns__content">
                  <a href="" target="_blank" rel="noreferrer">네이버 블로그</a>
              </p>
          </div>
          <div class="Footer_company">
              <p class="Footer_company__title">해볼랑스</p>
              <p class="Footer_company__content">
                  조장 : 이 단 | 조원 : 윤지수, 서상현, 서재식, 용수진, 박주진 <br/>
                  이메일 : habollangce@four.zo | 대표번호 : 070-7777-7777<br/>
                  주소 : 서울특별시 마포구 월드컵북로 21 풍성빌딩 3층 <br/>
                  사업자등록번호 : 846-86-01452 | 통신판매 : 제 2022-서울강남-00623<br/>
              </p>
              <p class="Footer_company__info">
                  <a href="/policy" target="_self">이용약관</a>
                  | <a href="/privacy" target="_self">개인정보처리방침</a>
                  | <a href="https://www.ftc.go.kr/bizCommPop.do?wrkr_no=8468601452" target="_self">사업자정보확인</a>
              </p>
          </div>
      </div>
  </footer>
