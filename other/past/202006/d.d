import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum n0 = [
    "###",
    "#.#",
    "#.#",
    "#.#",
    "###"];
enum n1 = [
    ".#.",
    "##.",
    ".#.",
    ".#.",
    "###"];
enum n2 = [
    "###",
    "..#",
    "###",
    "#..",
    "###"];
enum n3 = [
    "###",
    "..#",
    "###",
    "..#",
    "###"];
enum n4 = [
    "#.#",
    "#.#",
    "###",
    "..#",
    "..#"];
enum n5 = [
    "###",
    "#..",
    "###",
    "..#",
    "###"];
enum n6 = [
    "###",
    "#..",
    "###",
    "#.#",
    "###"];
enum n7 = [
    "###",
    "..#",
    "..#",
    "..#",
    "..#"];
enum n8 = [
    "###",
    "#.#",
    "###",
    "#.#",
    "###"];
enum n9 = [
    "###",
    "#.#",
    "###",
    "..#",
    "###"];

void main()
{
    auto N = readln.chomp.to!int;
    char[][5] ss;
    foreach (i; 0..5) ss[i] = readln.chomp.to!(char[]);
    int[] res;
    foreach (j; 0..N) {
        char[][] n;
        foreach (i; 0..5) n ~= ss[i][(4 * (j+1) - 3) .. (4 * (j+1))];
        if (n == n1) {
            res ~= 1;
        } else if (n == n2) {
            res ~= 2;
        } else if (n == n3) {
            res ~= 3;
        } else if (n == n4) {
            res ~= 4;
        } else if (n == n5) {
            res ~= 5;
        } else if (n == n6) {
            res ~= 6;
        } else if (n == n7) {
            res ~= 7;
        } else if (n == n8) {
            res ~= 8;
        } else if (n == n9) {
            res ~= 9;
        } else if (n == n0) {
            res ~= 0;
        }
    }
    writeln(res.to!(string[]).join(""));
}