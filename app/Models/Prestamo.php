<?php

namespace App\Models;

use DateTime;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prestamo extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "user_desembolso_id",
        "user_aprobado_id",
        "cliente_id",
        "tipo",
        "grupo_id",
        "monto",
        "plazo",
        "f_ci",
        "f_luz",
        "f_agua",
        "croquis",
        "documento_1",
        "documento_2",
        "documento_3",
        "documento_4",
        "estado",
        "desembolso",
        "fecha_desembolso",
        "finalizado",
        "fecha_aprobado",
        "fecha_rechazado",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t", "fecha_desembolso_t", "sw_desembolso", "nro_pagos_realizados", "ultima_fecha_pago", "ultimo_pago", "pagos_tiempo", "pagos_mora", "pagos_pendiente"];

    public function getPagosTiempoAttribute()
    {
        $pagos = Pago::where("cliente_id", $this->id)->get();

        $contador = 0;
        $ultimo_pago = null;
        foreach ($pagos as $pago) {
            $ultimo_pago = $pago;
            if ($pago->nro_cuota != 0 && (float)$pago->monto_mora == 0) {
                $contador++;
            } else {
                if ($ultimo_pago->nro_cuota == 0 && (float)$pago->monto_mora == 0) {
                    $plazo = $pago->prestamo->plazo;
                    $contador += (int)$plazo - (int)$ultimo_pago->nro_cuota;
                }
            }
        }
        return $contador;
    }
    public function getPagosMoraAttribute()
    {
        $pagos = Pago::where("cliente_id", $this->id)->get();

        $contador = 0;
        $ultimo_pago = null;
        foreach ($pagos as $pago) {
            $ultimo_pago = $pago;
            if ($pago->nro_cuota != 0 && (float)$pago->monto_mora > 0) {
                $contador++;
            } else {
                if ($ultimo_pago->nro_cuota == 0 && (float)$pago->monto_mora > 0) {
                    $plazo = $pago->prestamo->plazo;
                    $contador += (int)$plazo - (int)$ultimo_pago->nro_cuota;
                }
            }
        }
        return $contador;
    }

    public function getPagosPendienteAttribute()
    {
        $plan_pagos = PlanPago::where("prestamo_id", $this->id)->where("cancelado", "NO")->get();
        if (count($plan_pagos) == 0) {
            $prestamo = Prestamo::find($this->id);
            $prestamo->finalizado = 1;
            $prestamo->save();
        }
        return count($plan_pagos);
    }

    public function getUltimoPagoAttribute()
    {
        $pago = Pago::where("prestamo_id", $this->id)->orderBy("id", "desc")->get()->first();
        return $pago;
    }

    public function getUltimaFechaPagoAttribute()
    {
        $ultimo_plan = PlanPago::where("prestamo_id", $this->id)->orderBy("nro_cuota", "desc")->get()->first();
        if ($ultimo_plan->fecha_pago) {
            return date("d/m/Y", strtotime($ultimo_plan->fecha_pago));
        }
        return "S/D";
    }

    public function getNroPagosRealizadosAttribute()
    {
        $nro_pagos = PlanPago::where("prestamo_id", $this->id)->where("cancelado", "SI")->get();
        return count($nro_pagos);
    }

    public function getSwDesembolsoAttribute()
    {
        if ($this->fecha_desembolso) {
            $fecha_actual = date("Y-m-d");
            if ($this->fecha_desembolso == $fecha_actual) {
                return true;
            }
        }
        return false;
    }

    public function getFechaDesembolsoTAttribute()
    {
        if ($this->fecha_desembolso) {
            return date("d-m-Y", strtotime($this->fecha_desembolso));
        }
        return null;
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d-m-Y", strtotime($this->fecha_registro));
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function o_desembolso()
    {
        return $this->hasOne(Desembolso::class, 'prestamo_id');
    }

    public function user_desembolso()
    {
        return $this->belongsTo(User::class, 'user_desembolso_id');
    }

    public function user_aprobado()
    {
        return $this->belongsTo(User::class, 'user_aprobado_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    public function grupo()
    {
        return $this->belongsTo(Grupo::class, 'grupo_id');
    }

    public function plan_pagos()
    {
        return $this->hasMany(PlanPago::class, 'prestamo_id');
    }
    public function pagos()
    {
        return $this->hasMany(Pago::class, 'prestamo_id')->orderBy("id", "desc");
    }

    public static function obtenerDiferenciaDias($fecha1, $fecha2)
    {
        $date1 = new DateTime($fecha1);
        $date2 = new DateTime($fecha2);

        $diferencia = $date1->diff($date2);

        if ($date1 >= $date2) {
            return $diferencia->days;
        } else {
            return -$diferencia->days;
        }
    }
}
