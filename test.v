(* example.v - Minimal Rocq / Coq proof examples *)

(* --- Section 1: simple arithmetic --- *)
Theorem plus_comm : forall n m : nat, n + m = m + n.
Proof.
  intros n m.
  induction n.
  - simpl. rewrite Nat.add_0_l. reflexivity.
  - simpl. rewrite IHn. rewrite Nat.add_succ_r. reflexivity.
Qed.

(* --- Section 2: even numbers --- *)
Definition even (n : nat) : Prop :=
  exists k, n = 2 * k.

Lemma even_plus : forall n m,
  even n -> even m -> even (n + m).
Proof.
  intros n m [k1 Hk1] [k2 Hk2].
  exists (k1 + k2).
  rewrite Hk1, Hk2.
  lia.
Qed.

(* --- Section 3: factorial function --- *)
Fixpoint fact (n : nat) : nat :=
  match n with
  | 0 => 1
  | S k => n * fact k
  end.

Lemma fact_1 : fact 1 = 1.
Proof.
  simpl. reflexivity.
Qed

