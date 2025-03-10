function logout() {
    fetch('/user/logout', {
        method: 'GET'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`Failed to fetch reservations. Status: ${response.status}`);
        }
        return response.text();
    })
    .then(response => {
        alert(response);
        window.location.reload();
    })
    .catch(error => {
        console.error('Error fetching reservations:', error);
    });
}