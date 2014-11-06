$(document).ready(function() {
	//Log In functionality
	$("#login").click(function () {
		var username = $("#username").val();
		var password = $("#password").val();

		if (!$("#username") || username.length == 0) {
			$("#logInError").text("Please enter username!");
			return;
		}

		if (!$("#password") || password.length == 0) {
			$("#logInError").text("Please enter password!");
			return;
		}

		var loginInfo = {
			"username": username,
			"password": password
		};

		$.post("./processLogin", loginInfo, function (data) {
			if (data) {
				$("#logInError").text(data);
			} else {
				window.location.href = './' + username;
			}
		});
	});

	//Create Account functionality
	$(".createAccount").click(function (event) {
		var fName = $(".firstname").val();
		var lName = $(".lastname").val();
		var email = $(".email").val();
		var uName = $(".user").val();
		var pWord = $(".user_password").val();
		var vWord = $(".verifypassword").val();

		if (!fName || !lName || !email || !uName || !pWord || !vWord || fName.length == 0 ||
			lName.length == 0 || email.length == 0 || uName.length == 0 ||
			pWord.length == 0 || vWord.length == 0) {
			$("#createAccountError").text("Please fill out the entire form");
		return;
	}

	var accountInfo = {
		"firstname": fName,
		"lastname": lName,
		"email": email,
		"username": uName,
		"password1": pWord,
		"password2": vWord,
	}

	$.post("./processRegistration", accountInfo, function (data) {
		if (data) {
			$("#createAccountError").text(data);
		} else {
			$("#createModal").modal('hide');
			window.location.href = './';
		}
	});
});

	//Creates a new album for the user
	$("#createalbum").click(function(e) {
		e.preventDefault();
		var albumName = $("#album_name").val();
		var albumGenre = $("#album_genre").val();
		var albumSummary = $("#album_summary").val();
		var albumImage = $("#album_image").val();
		var location = window.location.pathname.split("/");
		var owner = location[location.length - 1];

		if (albumName.length == 0 || albumGenre.length == 0 || albumSummary.length == 0 || albumImage.length == 0) {
			$("#createAlbumError").text("Please enter information for all the fields!");
			return;
		}

		$("#albumForm").submit(function(e) {
			var formObj = $(this);
			var formData = new FormData(this);

			$.ajax({
				url: "./album/create",
				type: 'POST',
				data:  formData,
				mimeType:"multipart/form-data",
				contentType: false,
				cache: false,
				processData:false,
				success: function(data, textStatus, jqXHR)
				{
					var data = JSON.parse(data);
					if (data.Error) {
						$("#createAlbumError").text(data.Error);
					} else {
						$("#trackModal").modal("hide");
						reloadPage();
					}
				},
				error: function(jqXHR, textStatus, errorThrown) 
				{
					$("#createAlbumError").text(jqXHR);
				}          
			});
			e.preventDefault(); 
		});
		$("#albumForm").submit();
	});

	//Gets and populates the album information in the modal
	$("#editAlbum").click(function(e) {
		e.preventDefault();
		var location = window.location.pathname.split("/");
		
		$.post("./album/get", {
			"album_owner": location[location.length - 2],
			"album_name": decodeURI(location[location.length - 1])
		}, function (data) {
			var album = JSON.parse(data);
			var albumName = $("#edit_album_name").val(album['album_name']);
			var albumGenre = $("#edit_album_genre").val(album['album_genre']);
			var albumSummary = $("#edit_album_summary").val(album['album_summary']);
		});
	});

	//Submits modified information for the album
	$("#editalbumbutton").click(function(e) {
		if ($("#edit_album_genre").val().length > 0 && $("#edit_album_summary").val().length > 0) {
			$("#albumFormEdit").submit(function(e) {

				var formObj = $(this);
				var formData = new FormData(this);
				
				$.ajax({
					url: "./album/update",
					type: 'POST',
					data:  formData,
					mimeType:"multipart/form-data",
					contentType: false,
					cache: false,
					processData:false,
					success: function(data, textStatus, jqXHR)
					{
						var data = JSON.parse(data);

						if (data["Error"]) {
							$("#albumEditError").text(data["Error"]);
						} else {
							$("#editAlbumModal").modal("hide");
							reloadPage();
						}
					}
				});
				e.preventDefault(); 
			});
			$("#albumFormEdit").submit();

		} else {
			$("#albumEditError").text("Please enter a value for the fields!");
			return;
		}
	});

	//Deletes the album from the database
	$("#deletealbumbutton").click(function(e) {
		e.preventDefault();
		var location = window.location.pathname.split("/");
		var album_owner = location[location.length - 2];
		var album_name = decodeURI(location[location.length - 1]);

		$.post("./album/delete", {
			"album_owner": album_owner,
			"album_name": album_name
		}, function (data) {
			if (data) {
				$("#albumDeleteError").text(data);
				return;
			} else {
				window.location.href = '../' + album_owner;
			}
		});
	});

	//Sends information about the logged-in user
	$(".profile").click(function() {
		$.post("me", function (data) {
			if (data) {
				curUser = JSON.parse(data);
				$("#firstname").val(curUser["first_name"]);
				$("#lastname").val(curUser["last_name"]);
				$("#email").val(curUser["email"]);
				$("#user").val(curUser["username"]);
			}
		});		
	});

	//Deletes account from database
	$("#deleteaccountbutton").click(function(e) {
		e.preventDefault();
		$.post("./delete", function (data) {
			if (data) {
				window.location.href = "./";
			}
		});
	});

	//Updates the account information for the user
	$("#updateaccount").click(function(e) {
		e.preventDefault();
		var fName = $("#firstname").val();
		var lName = $("#lastname").val();
		var email = $("#email").val();
		var user = $("#user").val();
		var pW = $("#user_password").val();
		var verPW = $("#verify_password").val();

		var hasEmailChanged = false;

		$("#email").on("input", function() {
			if ($("#email").val() != email) {
				hasEmailChanged = true;
			}
		});

		if (fName.length == 0 || lName.length == 0 || email.length == 0 || user.length == 0) {
			$("#editProfileError").text("All values except Password and Verify Password are mandatory!");
			return;
		}

		if (pW.length > 0 && pW !== verPW) {
			$("#editProfileError").text("Please make sure passwords match before updating!");
			$("#user_password").val("");
			$("#verify_password").val("");
			return;
		} else {
			var updatedInformation = {
				"first_name": fName,
				"last_name": lName,
			};

			if (pW) {
				updatedInformation["password"] = pW;
			}

			if (hasEmailChanged) {
				updatedInformation['email'] = email;
			}
			
			$.post("./updateUser", updatedInformation, function (data) {
				if (data) {
					$("#editProfileError").text(data);
				} else {
					$("#editModal").modal('hide');
					window.location.href = "./" + user;
				}
			});
		}
	});

	//Sends password for forgot email
	$("#email_pw").click(function() {
		var email = $("#email_pass").val();

		if (email.length > 0) {
			$("#forgotModal").modal("toggle");
		} else {
			$("#forgotPasswordError").text("Enter email!");
		}
	});

	//Logs user off
	$("#logoff").click(function() {
		window.location.href='./index.html';
	});

	//Sorts the list view by genre
	$("#genre_select").change(function() {
		var selected =  $(this).children(":selected").text();

		if (window.location.href.indexOf("featured/") > -1) {
			window.location.href = encodeURIComponent(selected);
		}
		else {
			window.location.href = "./featured/" + encodeURIComponent(selected);
		}
	});

	//Reveals and populates track modal
	$("#trackModalButton").click(function() {
		var location = window.location.pathname.split("/");
		$("#track_album").val(decodeURI(location[location.length - 1]));
		$("#track_name").val("");
		$("#track_data").val("");
	})

	//Creates a new track for that album
	$("#createtrack").click(function(e) {
		e.preventDefault();
		var track_name = $("#track_name").val();
		var track_path = $("#track_data").val();

		if (track_name.length == 0 || !track_path) {
			$("#trackCreateError").text("Please fill the entire form!");
			return;
		} else {
			var location = window.location.pathname.split("/");

			$("#trackForm").submit(function(e) {
				var formObj = $(this);
				var formData = new FormData(this);

				$.ajax({
					url: "../track/create",
					type: 'POST',
					data:  formData,
					mimeType:"multipart/form-data",
					contentType: false,
					cache: false,
					processData:false,
					success: function(data, textStatus, jqXHR)
					{
						var data = JSON.parse(data);
						if (data.Error) {
							$("#trackCreateError").text(data.Error);
						} else {
							$("#trackModal").modal("hide");
							reloadPage();
						}
					},
					error: function(jqXHR, textStatus, errorThrown) 
					{
						$("#trackCreateError").text(jqXHR);
					}          
				});
				e.preventDefault(); 
			});
			$("#trackForm").submit();
		}
	});

	//Reveals and populates the delete track modal	
	$(".deletetrack").click(function (e) {
		e.preventDefault();
		var data = $(this).val();
		$("#deletetrackbutton").val(data);
		$("#deleteTrackLabel").text("Are you sure you want to delete the track \""+data+"\"?");
	});

	//Deletes track for that album
	$("#deletetrackbutton").click(function(e) {
		e.preventDefault();
		var location = window.location.pathname.split("/");

		var trackName = $(this).val();
		var trackAlbum = decodeURI(location[location.length - 1]);

		$.post("../track/delete", {
			"track_name": trackName,
			"track_album": trackAlbum
		}, function (data) {
			var data = JSON.parse(data);
			if (data.Error) {trackDeleteError
				$("#trackDeleteError").text(data.Error);
			}
			else {
				reloadPage();
			}
		});
	});

	//Reveals and populates the edit track modal	
	$(".edittrack").click(function (e) {
		e.preventDefault();
		var data = $(this).val();
		$("#old_track").val(data);
	});

	//Used to change the name of a track
	$("#track_edit_submit").click(function (e) {
		e.preventDefault();
		var location = window.location.pathname.split("/");
		var trackAlbum = decodeURI(location[location.length - 1]);
		var trackName = $("#new_track").val();
		var oldTrackName = $("#old_track").val();

		if ($("#new_track").val().length == 0) {
			$("#trackEditError").text("Please enter a valid new track name!");
			return;
		}
		$.post("../track/edit", {
			"track_name": trackName,
			"track_album": trackAlbum,
			"old_track_name": oldTrackName
		}, function (data) {

			var data = JSON.parse(data);

			if (data.Error) {
				$("#trackEditError").text(data.Error);
			} else {
				reloadPage();
			}
		});		
	});

	//Downloads the specified track
	$(".downloadtrack").click(function(e) {
		e.preventDefault();
		var path = $(this).val().split("/");
		window.location.href = "../track/download/"+path[path.length - 1];
	});

	//Adds comment to page
	$("#comment").click(function (e) {
		e.preventDefault();
		var commentText = $("#comment_area").val();

		if (commentText.length > 0) {
			var path = location.pathname.split("/");
			var albumOwner = path[path.length - 2];
			var albumName = path[path.length - 1];
			console.log("Album Owner: " + albumOwner);
			console.log("Album Name: " + albumName);
			$.post("../comment", {
				"album_owner": albumOwner,
				"album_name": albumName,
				"comment": commentText
			}, function (data) {
				location.reload();
			});
		}
	});

	//Delete comments from page
	$(".delete_comment").click(function (e) {
		var idToDelete = $(this).val().split("_")[2];

		$("#" + $(this).val()).remove();
		$(this).remove();
		

		$.post("../comment/delete", {
			id: idToDelete
		});
	});

	//Send a collaborate request to a user
	$("#collaborate").click(function (e) {
		var path = location.pathname.split("/");
		var collabWith = path[path.length - 1];

		$.post("./collaborate", {
			"collaborator": collabWith
		}, function (data) {
			location.reload();
		});
	});

	//Accepts request from the user's profile page
	$("#accept").click(function (e) {
		var path = location.pathname.split("/");
		var collabWith = path[path.length - 1];

		$.post("./collaborate", {
			"collaborator": collabWith
		}, function (data) {
			location.reload();
		});
	});

	//Uncollaborate with a user
	$("#uncollaborate").click(function (e) {
		var path = location.pathname.split("/");
		var collabWith = path[path.length - 1];

		$.post("./uncollaborate", {
			"collaborator": collabWith
		}, function (data) {
			location.reload();
		});
	});

	$(".accept_request").click(function (e) {
		var userCollab = $(this).val();

		$.post("./collaborate", {
			"collaborator": userCollab
		}, function (data) {
			location.reload();
		});
	});

	$(".deny_request").click(function (e) {
		var cancelCollab = $(this).val();

		$.post("./uncollaborate", {
			"collaborator": cancelCollab
		}, function (data) {
			location.reload();
		});
	});

	//Reloads page, here because I used location as a local variable a lot
	function reloadPage() {
		location.reload();
	}

	/***********DUMMY FUNCTIONS FOR OTHER TABS***************/

	$("#publish").click(function() {
		alert("It will insert a new project in My Music category");
	});

	$("#add_iter_btn").click(function() {
		if ($("#description").val() && $("#description").val().length > 0) {
			alert("This will add new iteration to the Lab");
			$("#iterModal").modal("hide");
			return;
		}
		alert("Please Enter a description");
	});

	$("#publish_lab").click(function() {
		alert("This will publish work to My Music");
	});

	$("#delete_lab").click(function() {
		alert("This will delete this lab session");
	});

	$(".download").click(function() {
		alert("This will download the song to your computer");
	});

	$(".edit").click(function() {
		alert("This will edit the song in Lab section");
	});

	$(".delete_song").click(function() {
		alert("This will delete your song");
	});

	$(".like").click(function() {
		alert("This will add a like to the song");
	});

	$(".collab").click(function() {
		alert("This will send a collab request for this song to creator");
	});
});