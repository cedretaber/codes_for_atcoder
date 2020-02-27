macro_rules! get {
    ($t:ty) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.trim().parse::<$t>().unwrap()
        }
    };
    ($($t:ty),*) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            let mut iter = line.split_whitespace();
            (
                $(iter.next().unwrap().parse::<$t>().unwrap(),)*
            )
        }
    };
    ($t:ty; $n:expr) => {
        (0..$n).map(|_|
            get!($t)
        ).collect::<Vec<_>>()
    };
    ($($t:ty),*; $n:expr) => {
        (0..$n).map(|_|
            get!($($t),*)
        ).collect::<Vec<_>>()
    };
}

fn solve(n: usize, s: &Vec<char>, mut r: Vec<char>) -> Option<String> {
    for i in 1..n-1 {
        let a = r[i];
        let b = r[i-1];
        if (a == 'S' && s[i] == 'o') || (a == 'W' && s[i] == 'x') {
            r.push(b);
        } else {
            r.push(if b == 'S' { 'W' } else { 'S' });
        }
    }
    let mut a = false;
    let mut b = false;
    if  (r[0] == 'S' && s[0] == 'o' && r[1] == r[n-1]) ||
        (r[0] == 'S' && s[0] == 'x' && r[1] != r[n-1]) ||
        (r[0] == 'W' && s[0] == 'o' && r[1] != r[n-1]) ||
        (r[0] == 'W' && s[0] == 'x' && r[1] == r[n-1]) { a = true; };
    if  (r[n-1] == 'S' && s[n-1] == 'o' && r[n-2] == r[0]) ||
        (r[n-1] == 'S' && s[n-1] == 'x' && r[n-2] != r[0]) ||
        (r[n-1] == 'W' && s[n-1] == 'o' && r[n-2] != r[0]) ||
        (r[n-1] == 'W' && s[n-1] == 'x' && r[n-2] == r[0]) { b = true; };
    
    if a && b {
        Some(r.into_iter().collect::<String>())
    } else {
        None
    }
}

fn main() {
    let n = get!(usize);
    let s = get!(String).chars().collect::<Vec<_>>();

    if let Some(r) = solve(n, &s, vec!['S', 'S']) { println!("{}", r); return; };
    if let Some(r) = solve(n, &s, vec!['S', 'W']) { println!("{}", r); return; };
    if let Some(r) = solve(n, &s, vec!['W', 'S']) { println!("{}", r); return; };
    if let Some(r) = solve(n, &s, vec!['W', 'W']) { println!("{}", r); return; };
    println!("-1");
}