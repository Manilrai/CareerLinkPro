<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("userId") == null ||
            !session.getAttribute("role").equals("recruiter")) {
        response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
        return;
    }
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

    <div class="page-header">
        <h1>📢 Post New Internship</h1>
        <a href="${pageContext.request.contextPath}/recruiter/dashboard"
           class="btn btn-outline">← Back to Dashboard</a>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>

    <div class="card">
        <form action="${pageContext.request.contextPath}/recruiter/postInternship" method="post">

            <div style="display:flex; gap:1.5rem; flex-wrap:wrap;">

                <div class="form-group" style="flex:1; min-width:200px;">
                    <label for="title">Internship Title *</label>
                    <input type="text" id="title" name="title"
                           placeholder="e.g. Java Developer Intern" required/>
                </div>

                <div class="form-group" style="flex:1; min-width:200px;">
                    <label for="location">Location *</label>
                    <input type="text" id="location" name="location"
                           placeholder="e.g. Kathmandu, Nepal" required/>
                </div>

            </div>

            <div class="form-group">
                <label for="description">Internship Description *</label>
                <textarea id="description" name="description"
                          placeholder="Describe the internship role, responsibilities..."
                          required></textarea>
            </div>

            <div style="display:flex; gap:1.5rem; flex-wrap:wrap;">

                <div class="form-group" style="flex:1; min-width:200px;">
                    <label for="duration">Duration *</label>
                    <input type="text" id="duration" name="duration"
                           placeholder="e.g. 3 months" required/>
                </div>

                <div class="form-group" style="flex:1; min-width:200px;">
                    <label for="stipend">Stipend</label>
                    <input type="text" id="stipend" name="stipend"
                           placeholder="e.g. NPR 10,000/month or Unpaid"/>
                </div>

                <div class="form-group" style="flex:1; min-width:200px;">
                    <label for="deadline">Application Deadline *</label>
                    <input type="date" id="deadline" name="deadline" required/>
                </div>

            </div>

            <!-- Skills Section -->
            <div class="form-group">
                <label>Required Skills *
                    <span style="font-weight:400; color:var(--gray); font-size:0.85rem;">
                        (Add skills one by one — used for Skill Gap Analysis)
                    </span>
                </label>

                <div id="skillsContainer">
                    <div class="skill-row" style="display:flex; gap:0.8rem; margin-bottom:0.8rem;">
                        <input type="text" name="skills"
                               placeholder="e.g. Java"
                               style="flex:1; padding:0.6rem 1rem; border:1px solid var(--border); border-radius:var(--radius);"/>
                        <button type="button" onclick="addSkill()"
                                class="btn btn-success" style="white-space:nowrap;">
                            + Add More
                        </button>
                    </div>
                </div>

                <small style="color:var(--gray);">
                    Add each required skill separately e.g. Java, MySQL, Git
                </small>
            </div>

            <div style="display:flex; gap:1rem; margin-top:1rem;">
                <button type="submit" class="btn btn-primary">
                    🚀 Post Internship
                </button>
                <a href="${pageContext.request.contextPath}/recruiter/dashboard"
                   class="btn btn-outline">Cancel</a>
            </div>

        </form>
    </div>
</div>

<script>
    function addSkill() {
        const container = document.getElementById('skillsContainer');
        const div = document.createElement('div');
        div.className = 'skill-row';
        div.style.cssText = 'display:flex; gap:0.8rem; margin-bottom:0.8rem;';
        div.innerHTML = `
            <input type="text" name="skills"
                   placeholder="e.g. MySQL"
                   style="flex:1; padding:0.6rem 1rem; border:1px solid var(--border); border-radius:var(--radius);"/>
            <button type="button" onclick="removeSkill(this)"
                    class="btn btn-danger" style="white-space:nowrap;">
                Remove
            </button>
        `;
        container.appendChild(div);
    }

    function removeSkill(btn) {
        btn.parentElement.remove();
    }

    // Set minimum deadline to today
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('deadline').min = today;
</script>

<%@ include file="../common/footer.jsp" %>
