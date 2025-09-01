document.addEventListener("DOMContentLoaded", () => {
	const careNumber = window.careNumber;
	const normalNumber = window.usersNumber;
	const commentListEl = document.querySelector(".comment_list");
	const commentBtn = document.querySelector("#comment_button");

	// 후기 작성
	commentBtn?.addEventListener("click", async () => {
		const contentEl = document.querySelector("#comment_text");
		const content = contentEl?.value.trim();
		if (!content) return alert("후기를 입력해주세요.");
		if (!careNumber || !normalNumber) return alert("care = " + careNumber  + " usersNumber : " + normalNumber + "둘 중 하나가 없습니다.");
		commentBtn.disabled = true;
		try {
			const response = await fetch("/comment/commentWriteOk.co", {
				method: "POST",
				headers: {
					"Content-Type": "application/json; charset=utf-8",
					"X-Requested-With": "XMLHttpRequest",
				},
				body: JSON.stringify({ careNumber, normalNumber, commentsContent: content }),
			});
			const result = await safeJson(response);
			if (result?.status === "success") {
				alert("댓글이 작성되었습니다.");
				if (contentEl) contentEl.value = "";
				await loadComments();
			} else {
				alert("댓글 작성에 실패했습니다.");
			}
		} catch (error) {
			console.error("댓글 작성 실패:", error);
			alert("댓글 작성 중 오류가 발생했습니다.");
		} finally {
			commentBtn.disabled = false;
		}
	});

	// 댓글 수정 및 삭제
	if (commentListEl) {
		commentListEl.addEventListener("click", async (e) => {
			const target = e.target;
			// 삭제
			if (target.matches(".del_btn")) {
				const commentsNumber = target.dataset.number;
				const commentWriter = target.dataset.user;
				if (!normalNumber) return;
				if (confirm("후기를 삭제하십니까?")) {
					if (String(normalNumber) !== String(commentWriter)) {
						alert("작성자가 아닙니다.");
						return;
					}
					try {
						const response = await fetch(
							`/comment/commentDeleteOk.co?commentsNumber=${encodeURIComponent(commentsNumber)}&normalNumber=${encodeURIComponent(normalNumber)}`,
							{
								method: "GET",
								headers: {
									"X-Requested-With": "XMLHttpRequest",
								},
							}
						);
						const result = await safeJson(response);
						if (result?.status === "success") {
							alert("댓글 삭제 완료");
							await loadComments();
						} else {
							alert("댓글 삭제 실패");
						}
					} catch (error) {
						console.error("댓글 삭제 실패 catch", error);
						alert("댓글 삭제 중 오류 발생으로 인해 실패하였습니다.");
					}
				}
			}

			// 수정 버튼 클릭
			if (target.matches(".edit_btn")) {
				const commentWriter = target.dataset.user;
				if (String(normalNumber) !== String(commentWriter)) {
					alert("작성자만 수정할 수 있습니다.");
					return;
				}

				const li = target.closest("li");
				if (!li) return;

				const contentDiv = li.querySelector(".comment_context");
				const originContent = contentDiv?.textContent?.trim() ?? "";

				if (contentDiv) {
					contentDiv.outerHTML = `<textarea class="modify_content">${originContent}</textarea>`;
				}

				const btnGroup = li.querySelector(".comment_btn_group");
				const commentsNumber = target.dataset.number;
				if (btnGroup) {
					btnGroup.innerHTML = `<button type="button" class="comment_modify" data-number="${commentsNumber}">수정 완료</button>`;
				}
				return;
			}

			// 수정 완료
			if (target.matches(".comment_modify")) {
				const commentsNumber = target.dataset.number;
				if (!commentsNumber) return;

				const li = target.closest("li");
				const newContent = li?.querySelector(".modify_content")?.value.trim();
				if (!newContent) return alert("후기 내용을 입력해주세요.");

				try {
					const response = await fetch("/comment/commentUpdateOk.co", {
						method: "POST",
						headers: {
							"Content-Type": "application/json; charset=utf-8",
							"X-Requested-With": "XMLHttpRequest",
						},
						body: JSON.stringify({ commentsNumber, commentsContent: newContent }),
					});

					const result = await safeJson(response);
					if (result?.status === "success") {
						alert("댓글이 수정되었습니다.");
						await loadComments();
					} else {
						alert("댓글 수정에 실패했습니다.");
					}
				} catch (error) {
					console.error("댓글 수정 실패:", error);
					alert("댓글 수정 중 오류가 발생했습니다.");
				}
			}
		});
	}

	console.log(careNumber + " 유저넘버");
	console.log(normalNumber + " gkkgk");

	// 후기 목록 불러오기
	async function loadComments() {
		if (!careNumber) return;
		try {
			const res = await fetch(`/comment/commentListOk.co?careNumber=${encodeURIComponent(careNumber)}`, {
				headers: {
					Accept: "application/json",
					"X-Requested-With": "XMLHttpRequest",
				},
			});
			if (!res.ok) throw new Error("후기 목록을 불러오는데 실패했습니다. res.ok 오류");
			const comments = await safeJson(res);
			renderComments(Array.isArray(comments) ? comments : []);
		} catch (error) {
			console.error("후기 목록 불러오기 실패:", error);
			alert("후기 목록을 불러오는데 실패했습니다.");
		}
	}
	
	// 후기 렌더링
	function renderComments(comments) {
		if (!commentListEl) return;
		commentListEl.innerHTML = "";
		if (!comments.length) {
			commentListEl.innerHTML = "<li>후기가 없습니다.</li>";
			return;
		}
		const frag = document.createDocumentFragment();
		let num = 1;
		comments.forEach((comment) => {
			const isMyComment = String(comment.normalNumber) === String(normalNumber);
			const li = document.createElement("li");
			li.innerHTML = `
			<div class="comment_div">
				<div class="comment_number">${num++}</div>
				<div class="comment_author">${comment.usersName}</div>
				<div class="comment_context">${comment.commentsContent}</div>
				<div class="comment_btn_group">
					<div class="comment_edit"><button class="edit_btn" data-number="${comment.commentsNumber}" data-user="${comment.normalNumber}" type="button">수정</button></div>
					<div class="comment_del"><button class="del_btn" data-number="${comment.commentsNumber}" data-user="${comment.normalNumber}" type="button">삭제</button></div>
				</div>
				<div class="comment_date">${comment.commentsUpdatedDate}</div>
			</div>
			`;
			frag.appendChild(li);
		});
		commentListEl.appendChild(frag);
	}

	// JSON 파싱 유틸
	async function safeJson(res) {
		const text = await res.text();
		try {
			return text ? JSON.parse(text) : null;
		} catch {
			return null;
		}
	}

	loadComments();
});


