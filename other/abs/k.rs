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
    let n = get!(usize);
    let mut ps = vec![(0,0,0); n];
    for i in 0..n {
        ps[i] = get!(i32, i32, i32);
    }
    let (mut x, mut y, mut t) = (0, 0, 0);
    for (pt, px, py) in ps {
        let dt = pt - t;
        let dd = (x - px).abs() + (y - py).abs();
        if dt < dd || (dt - dd) % 2 == 1 {
            println!("No");
            return;
        }
        x = px;
        y = py;
        t = pt;
    }
    println!("Yes");
}