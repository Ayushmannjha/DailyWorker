<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <link rel="stylesheet" href="./style.css">
<title>Worker Registration Form</title>
<style>
#acstatus{
backaground-color: black;
color: white;
}

</style>
</head>
<body>
	<div class="container">
		

		<div class="form-container">
			<h1>Worker Registration Form</h1>
			<form action="WorkerLogin.jsp" method="post">
				<input type="text" name="name" placeholder="Your Name" required>
            <input type="text" name = "specailty" placeholder="Preffered Work " required>
            
            <input type="tel" name = "phone" placeholder="Phone Number" required>
            <input type="email" name = "email" placeholder="Your Email" required>

            <input type="text" name="state" placeholder="State" required>
            <input type="text" name="district" placeholder="City" required>
            <input type="number" name="pincode" placeholder="Pin Code" required>
            <input type="password" placeholder="Create A Password" required>
            <input type="password" name = "password" placeholder="Confirm Password" required>
             
            <input type="submit" value="Register" class="btn " style="cursor: pointer;">
			</form>
			<script>
				const districtsData = {
					"Andhra Pradesh" : [ "Anantapur", "Chittoor", "Kurnool", /* Add other districts of Andhra Pradesh */],
					"Arunachal Pradesh" : [ "Changlang", "East Kameng",
							"West Kameng", /* Add other districts of Arunachal Pradesh */],
					"Bihar" : [ "Araria", "Begusarai", "Patna", "Darbhanga", /* Add other districts of Bihar */],
				/* Add other states and their corresponding districts data here */
				};

				const stateDropdown = document.getElementById('state');
				const districtDropdown = document.getElementById('district');

				stateDropdown.addEventListener('change', function() {
					const selectedState = stateDropdown.value;
					populateDistrictsDropdown(selectedState);
				});

				function populateDistrictsDropdown(state) {
					districtDropdown.innerHTML = "<option value=''>Select District</option>";
					if (state && districtsData[state]) {
						districtsData[state].forEach(function(district) {
							const option = document.createElement('option');
							option.value = district;
							option.textContent = district;
							districtDropdown.appendChild(option);
						});
					}
				}
			</script>

			<%!public static boolean validPhone(String s) {
		Pattern p = Pattern.compile("(0|91)?[6-9][0-9]{9}");
		Matcher m = p.matcher(s);
		if (m.find() && m.group().equals(s)) {
			return true;
		} else {
			return false;
		}
	}

	public static boolean validName(String s) {
		Pattern p = Pattern.compile("^[a-zA-Z]+(?:[\\s-][a-zA-Z]+)*$");
		Matcher m = p.matcher(s);
		if (m.find() && m.group().equals(s)) {
			return true;
		} else {
			return false;
		}
	}
	
	public static boolean validPassword(String s) {
		String passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$";

		Pattern p = Pattern.compile(passwordRegex);
		Matcher m = p.matcher(s);
		if (m.find() && m.group().equals(s)) {
			return true;
		} else {
			return false;
		}
	}
	%>
			<%
			String succfail = "";
			String anyissue = "";

			// Check if the form has been submitted
			if (request.getMethod().equalsIgnoreCase("post")) {
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String phone = request.getParameter("phone");
				String state = request.getParameter("state");
				String district = request.getParameter("district");
				String specialty = request.getParameter("specailty");
				String password = request.getParameter("password");
				
				String pincode = request.getParameter("pincode");
				
				// Validate that all required fields are filled
				if (name != null && !name.isEmpty() && email != null && !email.isEmpty() && phone != null && !phone.isEmpty()
				&& state != null && !state.isEmpty() && district != null && !district.isEmpty() && specialty != null
				&& !specialty.isEmpty()) {

					try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system",
						"manager");
				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO labourinfo VALUES(?, ?, ?, ?, ?, ?)");
					PreparedStatement pst1 = con.prepareStatement("insert into users values(?,?)");
				// Validate name and phone using the regex patterns
				if (validName(name)) {
					pst.setString(1, name);
				} else {
					anyissue = ("<p>Invalid name</p>");
					name = request.getParameter("name");
				}

				pst.setString(2, email);
				pst1.setString(1,phone);
				if(validPassword(password)){
					pst1.setString(2, password);
				}
				else{
					anyissue = ("<p>Invalid password</p>");
					password = request.getParameter("password");
				}
				if (validPhone(phone)) {
					pst.setString(3, phone);
				} else {
					anyissue = ("<p>Invalid phone number</p>");
					phone = request.getParameter("phone");
				}

				pst.setString(4, specialty);
				pst.setString(5, state + " - " + district+"-"+pincode);
				pst.setInt(6, 0);
				int status = pst.executeUpdate();
				int status1 = pst1.executeUpdate();
				pst.close();
				pst1.close();
				con.close();

				if (status > 0&&status1>0) {
					succfail = "Your account created successfully";
				} else {
					out.println("<p>Something went wrong. Please try again.</p>");
				}
					} catch (java.sql.SQLIntegrityConstraintViolationException e) {
				out.println("<p>User already exists.</p>");
					} catch (Exception e) {
						 e.printStackTrace();
				out.println("<p>Something went wrong. Please try again.</p>");
					}
				} else {
					out.println("<p>Please fill all the required fields.</p>");
					System.out.println(name +" "+ email +" "+phone+ " "+ state + " "+district+ " "+ specialty+" " +password);
				}
			}
			%>
			<p id="acstatus"><%=succfail%></p>
			<p id="acstatus"><%=anyissue%></p>
			<p id="acstatus"><a href = "Login.html">Go to login page</a></p>
		</div>
	</div>
</body>
</html>
