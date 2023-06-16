<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

    div.container-md {
        min-height: 88vh;
    }
    #reports > * {
        border: solid 1px black;
    }
    .line-wrapper:nth-child(even) {
        background-color: #e2ebf1;
    }

    .line-wrapper {
        overflow: hidden;
    }

    .input-wrap {
        padding: 2.7% 5% 2% 5%;
        float: left;
    }
    button#cancel {
        margin: 1% 0;
        position: relative;
        left: 92%;
        height: 50px;
    }
    .scheme {
        font-size: x-large;
    }
    .admin-line {
        display: flex;
        justify-content: space-around;
        padding: 2% 0;
    }
    .admin-line > *{
        flex: 1;
        text-align: center;
    }
    h2 {
        margin-top: 10%;
    }

    .popover {
        max-width: 1000px;
    }
</style>


    <div class="container-md">
        <h2> 신고 내역 </h2>
        <button id="cancel" class="btn btn-danger" type="button">인증 무효</button>
        <div id="reports">
        </div>
    </div>


<script>

    $(document).ready( () => {


        const dels = localStorage.getItem("deletes");

        if(dels != null) {
            const dels_arr = dels.split(",");

            dels_arr.forEach(function(item){
                $('div.sist').each(function(index, itm) {
                    const num = $(itm).attr('data-sist').val();

                    if(item == num) {
                        $('div.sist').hide();
                    }

                });
            });
        }
        const exec_arr = [];

        $.ajax({
            url: '/admin/report-load',
            type: 'GET',
            dataType: 'JSON',
            success: function (json) {

                let html = `<div class="line-wrapper">
                                <div class="input-wrap" id="all-wrap"><input type="checkbox" class="check" id="all"/></div>
                                <div class="admin-line scheme">
                                    <div>챌린지 번호</div>
                                    <div> 내용</div>
                                    <div> 사진</div>
                                </div>
                            </div>`;

                const arr = Array.from(json);

                arr.forEach( (item) => {
                    html += `<div class="line-wrapper sist" data-sist="\${item.certifyNo}">
                                <div class="input-wrap select"><input type="checkbox" class="check" name="exec" value="\${item.reportNo}"/></div>
                                <div class="admin-line">
                                    <div class="cert" data-toggle="popover" data-placement="left" title="이번달 판매순위 정보제공" data-html="true" data-content="<div></div><div>챌린지 인증방법</div>">\${item.certifyNo}</div>
                                    <div class="content">\${item.reportContent}</div>
                                    <div class="pic"><img src="\${item.certifyImg}"/></div>
                                </div>
                            </div>`;
                });

                document.getElementById('reports').innerHTML=html;

            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });

        // 전체 체크
        $(document).on('click', '#all-wrap', () => {
            const checked = $('input#all').prop('checked');
            if(checked) {
                $('input#all').prop('checked', false);
                $('input[name="exec"]').prop('checked', false);
            } else {
                $('input#all').prop('checked', true);
                $('input[name="exec"]').prop('checked', true);
            }
        });

        // 개별 체크
        $(document).on('click', 'div.select', (e) => {

            const checked = $(e.target).find('input').prop('checked');

            if(checked) {
                $(e.target).find('input').prop('checked', false);
            } else {
                $(e.target).find('input').prop('checked', true);
            }

            const checkedLength = Array.from($('input[name="exec"]:checked')).length;
            const totalLength = Array.from($('input[name="exec"]')).length;

            const bool = (checkedLength == totalLength);

            if(bool) {
                $('input#all').prop('checked', true);
            } else {
                $('input#all').prop('checked', false);
            }
            // $('input[name="exec"]:checked').each((item) => {
            //     exec_arr.push($(item).val());
            // });

        });

        $(document).on('click','button#cancel', () => {
            const exec_arr = [];

            $('input[name="exec"]:checked').each((i, item) => {
                exec_arr.push($(item).val());
            });

            deleteReports(exec_arr.join(","));
        });


    });

    function deleteReports(string) {

        // console.log(exec_arr);
        // console.log(exec_arr.join());
        // console.log(typeof exec_arr.join());
        $.ajax({
            url: '/admin/report-load',
            type: 'POST',
            data: { "arr" : string },
            dataType: 'JSON',
            success: function (json) {
                console.log(string.split(","));
                localStorage.setItem("deletes", string);
                // location.href = '/admin/report';
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }

    $(document.body).popover({
        selector: "[data-toggle='popover']"
    });
</script>