// middlewares/authMiddleware.js
export const isAuthenticated = (req, res, next) => {
    if (req.session && req.session.isAuthenticated) {
        return next(); // User is authenticated, proceed to the next middleware or route
    }
    res.redirect('/admin/login'); // Redirect to login if not authenticated
};

