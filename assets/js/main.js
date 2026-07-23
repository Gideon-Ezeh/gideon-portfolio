// Mobile nav toggle
const navToggle = document.querySelector(".nav-toggle");
const nav = document.querySelector(".nav");

if (navToggle && nav) {
  navToggle.addEventListener("click", () => {
    nav.classList.toggle("open");
    navToggle.classList.toggle("open");
  });

  document.querySelectorAll(".nav-links a").forEach((link) => {
    link.addEventListener("click", () => {
      nav.classList.remove("open");
      navToggle.classList.remove("open");
    });
  });
}

// Highlight active nav link based on scroll position (home page only)
const sections = document.querySelectorAll("main section[id]");
const navLinks = document.querySelectorAll(".nav-links a[href^='#']");

if (sections.length && navLinks.length) {
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const id = entry.target.getAttribute("id");
          navLinks.forEach((link) => {
            link.classList.toggle("active", link.getAttribute("href") === `#${id}`);
          });
        }
      });
    },
    { rootMargin: "-40% 0px -50% 0px" }
  );
  sections.forEach((section) => observer.observe(section));
}

// Reveal-on-scroll
const revealEls = document.querySelectorAll(".reveal");
if (revealEls.length) {
  const revealObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible");
          revealObserver.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.15 }
  );
  revealEls.forEach((el) => revealObserver.observe(el));
}

// Contact form: Netlify handles the actual submission (data-netlify="true").
// This just gives the user feedback without a page reload.
const contactForm = document.querySelector("#contact-form");
if (contactForm) {
  contactForm.addEventListener("submit", (e) => {
    // Skip AJAX handling when running locally (file:// or no Netlify backend) —
    // let the note under the form explain that submissions go live once deployed.
    const status = contactForm.querySelector(".form-status");
    if (window.location.protocol === "file:") {
      e.preventDefault();
      status.textContent = "Forms only submit once this site is deployed to Netlify.";
      status.classList.add("show", "error");
      return;
    }

    e.preventDefault();
    const data = new FormData(contactForm);

    fetch("/", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams(data).toString(),
    })
      .then((response) => {
        if (!response.ok) throw new Error(`Form submission failed: ${response.status}`);
        status.textContent = "Thanks! Your message has been sent — I'll be in touch soon.";
        status.classList.remove("error");
        status.classList.add("show", "success");
        contactForm.reset();
      })
      .catch(() => {
        status.textContent = "Something went wrong. Please email me directly instead.";
        status.classList.remove("success");
        status.classList.add("show", "error");
      });
  });
}
