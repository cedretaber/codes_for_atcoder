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
    ($t:ty ;;) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.split_whitespace()
                .map(|t| t.parse::<$t>().unwrap())
                .collect::<Vec<_>>()
        }
    };
    ($t:ty ;; $n:expr) => {
        (0..$n).map(|_| get!($t ;;)).collect::<Vec<_>>()
    };
}

fn main() {
    let (sx, sy, tx, ty) = get!(i32, i32, i32, i32);
    let dx = tx - sx;
    let dy = ty - sy;

    let mut r = String::new();
    for _ in 0..dx { r.push('R'); }
    for _ in 0..dy { r.push('U'); }
    for _ in 0..dx { r.push('L'); }
    for _ in 0..dy { r.push('D'); }
    r.push('D');
    for _ in 0..dx+1 { r.push('R'); }
    for _ in 0..dy+1 { r.push('U'); }
    r.push('L');
    r.push('U');
    for _ in 0..dx+1 { r.push('L'); }
    for _ in 0..dy+1 { r.push('D'); }
    r.push('R');

    println!("{}", r);
}