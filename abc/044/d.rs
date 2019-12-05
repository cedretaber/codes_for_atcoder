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
    let n = get!(i64);
    let s = get!(i64);

    let mut i: i64 = 2;
    while i.pow(2) <= n {
        let mut x = 0;
        let mut j = n;
        while j != 0 {
            x += j % i;
            j /= i;
        }
        if x == s {
            println!("{}", i);
            return;
        }
        i += 1;
    }
    while i > 1 {
        i -= 1;
        let b = (n - s + i) / i;
        if b >= 2 && (n/b)%b + n%b == s {
            println!("{}", b);
            return;
        }
    }
    if n == s {
        println!("{}", n+1);
        return;
    }
    println!("-1");
}

/*

n/b + n%b = s

ここで、 n/b = i と置く。

n%b = s - i

ということは、 n - n%b = n - s + i

ところで、 n/b = i なので、 b = (n - s + i) / i <=> (s - i) / i

*/