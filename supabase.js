// 1) Paste your own values from Supabase -> Project Settings -> API
const SUPABASE_URL = "https://heorpkfzjprkmdjgtvjf.supabase.co";
const SUPABASE_KEY = "sb_publishable_xWN3ao5wkIgAWa-OjxYuwA_QbAFLg9o";
const db = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

const $ = (id) => document.getElementById(id);
const esc = (s) => String(s ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));

async function requireRole(role) {
  const { data: { user } } = await db.auth.getUser();
  if (!user) { location.href = "index.html"; return null; }
  const { data: p } = await db.from("profiles").select("*").eq("id", user.id).single();
  if (!p || p.role !== role) { location.href = "index.html"; return null; }
  return p;
}
async function logout() { await db.auth.signOut(); location.href = "index.html"; }
